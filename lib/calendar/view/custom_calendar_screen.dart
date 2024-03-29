import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odltd/calendar/const/holidays_data.dart';

class CustomCalendarScreen extends StatefulWidget {
  const CustomCalendarScreen({super.key});

  @override
  State<CustomCalendarScreen> createState() => _CustomCalendarScreenState();
}

class _CustomCalendarScreenState extends State<CustomCalendarScreen> {
  DateTime _currentDate = DateTime.now();

  void gotoPreviousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }

  void gotoNextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final daysBefore = firstDayOfMonth.weekday % 7;
    final firstToDisplay = firstDayOfMonth.subtract(Duration(days: daysBefore));

    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    final daysAfter = 7 - lastDayOfMonth.weekday % 7;
    final lastToDisplay = lastDayOfMonth.add(Duration(days: daysAfter));

    List<DateTime> days = [];
    for (DateTime d = firstToDisplay;
        d.isBefore(lastToDisplay);
        d = d.add(const Duration(days: 1))) {
      days.add(d);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_currentDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      body: Column(
        children: <Widget>[
          CalendarHeader(
            currentDate: _currentDate,
            onPreviousMonth: gotoPreviousMonth,
            onNextMonth: gotoNextMonth,
          ),
          Expanded(
            child: CalendarGrid(
                daysInMonth: daysInMonth, currentDate: _currentDate),
          ),
        ],
      ),
    );
  }
}

class CalendarHeader extends StatelessWidget {
  final DateTime currentDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const CalendarHeader({
    Key? key,
    required this.currentDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onPreviousMonth,
        ),
        Text(
          DateFormat('yyyy년 MM월').format(currentDate),
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: onNextMonth,
        ),
      ],
    );
  }
}

class CalendarGrid extends StatelessWidget {
  final List<DateTime> daysInMonth;
  final DateTime currentDate;

  const CalendarGrid(
      {Key? key, required this.daysInMonth, required this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: daysInMonth.length,
      itemBuilder: (context, index) {
        final day = daysInMonth[index];
        return DayTile(day: day, currentDate: currentDate);
      },
    );
  }
}

// DayTile 클래스
class DayTile extends StatelessWidget {
  final DateTime day;
  final DateTime currentDate;

  const DayTile({Key? key, required this.day, required this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSunday = day.weekday == DateTime.sunday;
    final isHolidayDay = isHoliday(day);
    final isToday = DateTime.now().day == day.day &&
        DateTime.now().month == day.month &&
        DateTime.now().year == day.year;

    final textColor = (isSunday || isHolidayDay) ? Colors.red : Colors.black;

    return InkWell(
      onTap: () {
        // 날짜별 일정 상세 보기 기능 구현 (예: 팝업 또는 다이얼로그 표시)
      },
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isToday ? Colors.blue[100] : Colors.white, // 오늘 날짜 강조
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            DateFormat('d').format(day),
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: currentDate.month == day.month ? textColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// 공휴일 확인을 위한 함수
bool isHoliday(DateTime date) {
  // 매년 동일한 공휴일 확인
  for (var holiday in commonHolidays) {
    if (holiday.date.month == date.month && holiday.date.day == date.day) {
      return true;
    }
  }

  // 해당 연도의 공휴일 확인
  var yearHolidays = yearlyHolidays[date.year];
  if (yearHolidays != null) {
    for (var holiday in yearHolidays) {
      if (holiday.date.month == date.month && holiday.date.day == date.day) {
        return true;
      }
    }
  }

  return false;
}
