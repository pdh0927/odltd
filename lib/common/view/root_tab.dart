import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odltd/common/const/colors.dart';
import 'package:odltd/common/layout/default_layout.dart';
import 'package:odltd/common/provider/root_tab_index_provider.dart';

class RootTab extends ConsumerStatefulWidget {
  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  // late : 나중에 무조건 null이 아니라 controller 사용전에 세팅 한다
  late TabController controller;

  @override
  void initState() {
    super.initState();
    // length : 몇 개 탭 사용할건지, vsync : 현재의  state 넣어주면 됨(그런데 SingleTickerProviderStateMixin이라는 기능 가지고 있어야함)
    controller = TabController(length: 3, vsync: this);
    // controller의 변경사항이 감지될 때마다 tabListener 함수 실행
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    ref.read(rootTabIndexProvider.notifier).state = controller.index;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BLACK_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller
                .animateTo((index)); // 현재 탭과 인덱스가 다를 경우, 애니메이션을 사용하여 탭을 부드럽게 전환
          },
          currentIndex: ref.watch(rootTabIndexProvider),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'My'),
          ]),
      child: TabBarView(
          physics: const NeverScrollableScrollPhysics(), // scroll로는 화면 전환 x
          controller: controller,
          children: const [
            Center(child: Text('Home')),
            Center(child: Text('Calendar')),
            Center(child: Text('My')),
          ]),
    );
  }
}
