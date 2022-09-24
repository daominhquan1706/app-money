import 'package:flutter/material.dart';
import 'package:moneylover/custom_colors.dart';
import 'package:moneylover/font_style.dart';

class ButtonTertiary extends StatelessWidget {
  const ButtonTertiary({
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
            backgroundColor: MaterialStateProperty.all<Color>(yellow),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          onPressed: onPress,
          child: Text(text, style: buttonText)),
    );
  }
}
