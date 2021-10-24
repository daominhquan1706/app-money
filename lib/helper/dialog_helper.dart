import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin DialogHelper {
  static void showSnackBar(String message) {
    EasyLoading.instance
      ..userInteractions = true
      ..dismissOnTap = false;
    EasyLoading.showToast(
      message,
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }

  static void showLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(status: "Vui lòng chờ...");
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }
}
