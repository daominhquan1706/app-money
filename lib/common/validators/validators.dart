import 'dart:async';

import 'package:moneylover/common/utils/validation_utils.dart';

class Validators {
  String validateEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  String validateEmail(value) {
    if (ValidationUtils.isValidEmail(value) || value.isEmpty) {
      return null;
    } else {
      return 'Please enter valid email';
    }
  }

  final validateNormal = StreamTransformer<String, String>.fromHandlers(
    handleData: (String value, EventSink<String> sink) {
      if (value.isNotEmpty) {
        sink.add(value);
      } else {
        sink.addError('This field cannot be empty');
      }
    },
  );

  // Validator
  bool _isStrongPassword(String input) {
    if (input?.isNotEmpty == true) {
      const Pattern hardPasswordPattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[\S ]{10,}$';
      return RegExp(hardPasswordPattern).hasMatch(input);
    }
    return false;
  }

  String validateStrongPassword(String input) {
    if ((input ?? '').isEmpty) {
      return 'This field cannot be empty';
    }
    bool isStrongPass = _isStrongPassword(input);
    if (isStrongPass) return null;
    return 'Password must include 10 characters with 1 uppercase, 1 lowercase, 1 digit & 1 special character';
  }
}
