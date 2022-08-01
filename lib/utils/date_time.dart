DateTime now = DateTime.now();
DateTime thisMonth = DateTime(now.year, now.month + 1, 0);
DateTime nextMonth = DateTime(now.year, now.month + 1 + 1, 0);

final day = <int>[];
final dayName = <String>[];
final monthNo = <int>[];
final monthName = <String>[];
const List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const List months = [
  'Jan',
  'Feb',
  'March',
  'Apr',
  'May',
  'June',
  'July',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

List<dynamic> getDate() {
  int tommorow = now.day + 1;
  int i = tommorow;
  int j = 0;
  while (day.length < 30) {
    day.add(i);
    dayName.add(weekdays[checkWeekDay(now.year, now.month + j, i) - 1]);
    monthName.add(months[checkMonth(now.year, now.month + j, i) - 1]);
    monthNo.add(now.month + j);

    if (thisMonth.day == i) {
      i = 0;
      j = 1;
    }

    i++;
  }

  return [day, dayName, monthName, monthNo];
}

int checkWeekDay(int year, int month, int day) {
  return DateTime(year, month, day).weekday;
}

int checkMonth(int year, int month, int day) {
  return DateTime(year, month, day).month;
}
