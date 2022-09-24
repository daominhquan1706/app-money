import 'package:get/get.dart';
import 'package:moneylover/common/utils/utils.dart';

class ValidationUtils {
  static bool isValidEmail(String email) {
    if (isEmpty(email)) {
      return false;
    }
    return email.isEmail;
  }

  static bool isTextOnly(String text) {
    if (isEmpty(text)) {
      return true;
    }
    return RegExp(r'^[a-z A-Z]+$').hasMatch(text);
  }

  static bool isValidPhoneNumber(String phone) {
    try {
      final value = phone.trim();

      bool checkUppercase = RegExp(".*[A-Z].*").hasMatch(value);
      bool checkLowercase = RegExp(".*[a-z].*").hasMatch(value);
      if (checkUppercase || checkLowercase) return false;

      const phonePrefix = '091, 094, 083, 084, 085, 081, 082 088 '
          '098, 097, 096, 039, 038, 037, 036, 035, 034, 033, 032 '
          '090 – 093 – 089 – 070 – 079 – 077- 076 – 078 '
          '092, 058, 056';

      return value.length == 10 &&
          value.startsWith('0') &&
          phonePrefix.contains(value.substring(0, 2));
    } catch (e) {
      return false;
    }
  }
}
