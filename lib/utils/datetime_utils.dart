


class DateTimeUtils{


  static String formatTimeDDMMYYHHMMSS(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String day = twoDigits(dateTime.day);
    String month = twoDigits(dateTime.month);
    String year = twoDigits(dateTime.year); // Lấy hai chữ số cuối của năm

    String hour = twoDigits(dateTime.hour);
    String minute = twoDigits(dateTime.minute);
    String second = twoDigits(dateTime.second);

    return '$day-$month-$year $hour:$minute:$second';
  }
}