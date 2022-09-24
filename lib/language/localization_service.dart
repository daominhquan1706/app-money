import 'package:flutter/material.dart' show Locale;
import 'package:get/get.dart';

class LocalizationService extends Translations {

// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('en', 'US');

  static Map<String, String> langs = {};

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    print("newLocale: $locale");
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {};

  static Locale _getLocaleFromLanguage({String langCode}) {
    var lang = langCode ?? Get.deviceLocale.languageCode;
    return Locale(lang);
  }
}