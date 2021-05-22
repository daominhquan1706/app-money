import 'package:intl/intl.dart';

class DateTimeHelper {
  DateTimeHelper._privateConstructor();
  static final DateTimeHelper instance = DateTimeHelper._privateConstructor();

  DateTime stringToDate(String str) {
    return DateFormat("yyyy-MM-ddThh:mm:ss").parse(str);
  }

  DateTime listIntToDate(List<int> d) {
    final str = "${d[0]}-${d[1]}-${d[2]}T${d[3]}:${d[4]}:${d[5]}";
    return DateFormat("yyyy-MM-ddThh:mm:ss").parse(str);
  }

  String dateToString(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }
}
