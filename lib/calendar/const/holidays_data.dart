import 'package:odltd/calendar/model/holiday_model.dart';

List<Holiday> commonHolidays = [
  Holiday(DateTime(0, 3, 1), '3·1 운동/삼일절'), // 연도는 중요하지 않으므로 0으로 설정
  Holiday(DateTime(0, 5, 5), '어린이날'),
  Holiday(DateTime(0, 6, 6), '현충일'),
  Holiday(DateTime(0, 8, 15), '광복절'),
  Holiday(DateTime(0, 10, 3), '개천절'),
  Holiday(DateTime(0, 10, 9), '한글날'),
  Holiday(DateTime(0, 12, 25), '크리스마스'),
];

Map<int, List<Holiday>> yearlyHolidays = {
  2024: [
    Holiday(DateTime(2024, 1, 1), '새해'),
    Holiday(DateTime(2024, 2, 9), '설날'),
    Holiday(DateTime(2024, 2, 10), '설날'),
    Holiday(DateTime(2024, 2, 11), '설날'),
    Holiday(DateTime(2024, 5, 15), '부처님 오신 날'),
    Holiday(DateTime(2024, 9, 16), '추석'),
    Holiday(DateTime(2024, 9, 17), '추석'),
    Holiday(DateTime(2024, 9, 18), '추석'),
  ],
  2025: [
    Holiday(DateTime(2025, 1, 1), '새해'),
    Holiday(DateTime(2025, 1, 28), '설날'),
    Holiday(DateTime(2025, 1, 29), '설날'),
    Holiday(DateTime(2025, 1, 30), '설날'),
    Holiday(DateTime(2025, 5, 8), '부처님 오신 날'),
    Holiday(DateTime(2025, 10, 5), '추석'),
    Holiday(DateTime(2025, 10, 6), '추석'),
    Holiday(DateTime(2025, 10, 7), '추석'),
  ],
  2026: [
    Holiday(DateTime(2026, 1, 1), '새해'),
    Holiday(DateTime(2026, 2, 16), '설날'),
    Holiday(DateTime(2026, 2, 17), '설날'),
    Holiday(DateTime(2026, 2, 18), '설날'),
    Holiday(DateTime(2026, 5, 8), '부처님 오신 날'),
    Holiday(DateTime(2026, 9, 24), '추석'),
    Holiday(DateTime(2026, 9, 25), '추석'),
    Holiday(DateTime(2026, 9, 26), '추석'),
    Holiday(DateTime(2026, 9, 27), '추석'),
  ],
};
