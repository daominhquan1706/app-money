import 'package:intl/intl.dart';

class DateTimeHelper {
  DateTimeHelper._privateConstructor();
  static final DateTimeHelper instance = DateTimeHelper._privateConstructor();

  DateTime stringToDate(String str) {
    return DateFormat("yyyy-MM-ddThh:mm:ss").parse(str);
  }
}
