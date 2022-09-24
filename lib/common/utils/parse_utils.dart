import 'package:flutter/material.dart' show Color, Colors;
import 'package:moneylover/common/utils/utils.dart';
import 'package:moneylover/common/utils/validation_utils.dart';

class ParseUtils {
  static T parse<T>(dynamic value, [T defaultValue]) {
    String str = value == null ? "" : "$value";
    if (T == double) {
      return double.tryParse(str) ?? defaultValue ?? 0.0 as T;
    } else if (T == int) {
      return int.tryParse(str) ?? defaultValue ?? 0 as T;
    } else if (T == String) {
      return str ?? defaultValue ?? "" as T;
    } else if (T == bool) {
      if (str.toLowerCase() == "true") {
        return true as T;
      } else if (str.toLowerCase() == "false") {
        return false as T;
      } else {
        return defaultValue ?? false as T;
      }
    }

    return value;
  }

  static Color parseColor(String hex, {Color fallback}) {
    if (isEmpty(hex)) return fallback ?? Colors.white;
    String prefix = hex.length == 6 ? "ff" : "";
    try {
      int value = int.tryParse('0x$prefix$hex');
      return Color(value);
    } catch (e) {
      return fallback ?? Colors.white;
    }
  }

  static String parsePhoneNumber(String value) {
    String phoneWithoutSpace = value.replaceAll(" ", "");
    if (ValidationUtils.isValidPhoneNumber(phoneWithoutSpace)) {
      return phoneWithoutSpace;
    }
    List<String> listPrefix = [
      "+840",
      "840",
      "(+840)",
      "(+84)0",
      "(+84)",
      "(840)",
      "(84)0",
      "(84)",
      "+84",
      "84"
    ];
    if (phoneWithoutSpace.length > 6) {
      for (int i = 0; i < listPrefix.length; i++) {
        if (phoneWithoutSpace.startsWith(listPrefix[i])) {
          return phoneWithoutSpace.replaceFirst(listPrefix[i], "0");
        }
      }
    }

    return "";
  }

  static String month(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return "";
  }
}
