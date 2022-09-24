import 'package:flutter/material.dart';
import 'package:moneylover/custom_colors.dart';
import 'package:moneylover/font_style.dart';

class InputText extends StatelessWidget {
  const InputText(
      {Key key,
      this.placeholder,
      this.controller,
      this.maxLines,
      this.obscureText = false,
      this.onTap})
      : super(key: key);

  final String placeholder;
  final int maxLines;
  final bool obscureText;
  final TextEditingController controller;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 355,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
              ),
              Text(
                placeholder,
                style: inputLabel,
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  onTap: onTap,
                  obscureText: obscureText,
                  maxLines: maxLines,
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: darkRed),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: darkRed),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: placeholder,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
