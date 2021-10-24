
import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin DialogHelper {
  static void showSnackBar(String message) {
    EasyLoading.instance
      ..userInteractions = true
      ..dismissOnTap = false;
    EasyLoading.showToast(message);
  }

  static void showLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(status: "Loading...");
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }
}
