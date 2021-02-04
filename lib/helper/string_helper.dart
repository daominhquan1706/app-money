import 'package:intl/intl.dart';

class StringHelper {
  static String getMoneyText(double amount) {
    return NumberFormat(",###").format(amount);
  }
}
