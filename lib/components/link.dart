import 'package:flutter/material.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({Key key, this.text, this.onPress, this.color})
      : super(key: key);

  final void Function() onPress;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
