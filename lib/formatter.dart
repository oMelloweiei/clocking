class Formatter {
  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static const List<String> _weekdayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  static String getMonthName(int month) {
    if (month < 1 || month > 12) return '';
    return _monthNames[month - 1];
  }

  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String getWeekdayName(DateTime dateTime) {
    return _weekdayNames[dateTime.weekday - 1];
  }

  static String formatDay(int day) {
    String daySuffix = getDaySuffix(day);
    return '$day$daySuffix';
  }

  static String formatMonth(int month) {
    return getMonthName(month);
  }

  static String formatYear(int year) {
    return '$year';
  }

  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formattedDate(String date) {
    List<String> parts = date.split('-');
    int year = int.parse(parts[2]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[0]);

    // Create a DateTime object
    DateTime dateTime = DateTime(year, month, day);

    String weekdayName = getWeekdayName(dateTime);
    String monthName = formatMonth(month);
    String dayFormatted = formatDay(day);
    String yearFormatted = formatYear(year);

    return '$weekdayName $dayFormatted $monthName $yearFormatted';
  }

  static String formattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
