import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateUtil {
  static DateTime convertLocalTimeToUTCTime(DateTime localTime) {
    return (localTime.toUtc()).add(localTime.timeZoneOffset);
  }

  static int currentLocalTimeToUTCTimestamp() {
    return (DateTime.now().toUtc()).add(DateTime.now().timeZoneOffset).millisecondsSinceEpoch;
  }

  static String formatDateToString(DateTime dateTime) {
    return new DateFormat.yMMMMd('en_US').add_jm().format(dateTime.toUtc());
  }

  static String formatDateToStringOnlyDate(DateTime dateTime) {
    return Jiffy(dateTime).EEEE + ", " + Jiffy(dateTime.toUtc()).yMMMMd;
  }

  static String formatDateToStringOnlyHourMinute(DateTime dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime.toString());
    final DateFormat formatterNew = DateFormat.jm();
    final String formattedNewDate = formatterNew.format(parsedDate);
    return formattedNewDate;
  }
}
