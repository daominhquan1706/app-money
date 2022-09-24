import 'package:flutter/material.dart';
import 'package:moneylover/custom_colors.dart';
import 'package:moneylover/font_style.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  final String text;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 355,
      height: 51,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(color: pink)),
            ),
          ),
          onPressed: onPress,
          child: Text(text, style: buttonTextSecondary)),
    );
  }
}
