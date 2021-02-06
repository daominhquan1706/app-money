import 'package:intl/intl.dart';

class StringHelper {
  StringHelper._privateConstructor();
  static final StringHelper instance = StringHelper._privateConstructor();

  String getMoneyText(double amount) {
    return NumberFormat(",###").format(amount);
  }
}
