import 'package:flutter/material.dart';
import 'package:moneylover/font_style.dart';

class socialmediaCard extends StatelessWidget {
  const socialmediaCard({Key key, this.imageLink, this.onPress, this.linked})
      : super(key: key);

  final void Function() onPress;
  final String imageLink;
  final bool linked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Image(image: AssetImage(imageLink), height: 80, width: 80),
          const SizedBox(height: 5),
          linked
              ? Text(
                  'Linked',
                  style: smallTextRed,
                )
              : Text(
                  'Unlinked',
                  style: smallText,
                )
        ],
      ),
    );
  }
}
