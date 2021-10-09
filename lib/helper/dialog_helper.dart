import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin DialogHelper {
  static void showSnackBar(BuildContext context, {String message}) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
