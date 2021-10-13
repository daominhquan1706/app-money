import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin DialogHelper {
  static void showSnackBar(BuildContext context, {String message}) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showLoading() {
    EasyLoading.show(status:"Loading...");
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }
}
