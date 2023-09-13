import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toFullDate(DateTime dateTime) {
    final date = DateFormat.MMMEd("pt_BR").format(dateTime);

    return '$date';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMMd().format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return '$time';
  }

  static String toAppointmentFormat(DateTime dateTime) {
    final formatted = DateFormat("d 'de' MMM HH:MM", "pt_BR").format(dateTime);

    return formatted;
  }
}
