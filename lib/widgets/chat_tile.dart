import 'package:flutter/material.dart';
import 'package:moneylover/font_style.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(children: [
        Row(
          children: [
            Image.asset(
              'assets/images/profile.jpeg',
              width: 50,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Animak",
                  style: smallText,
                ),
                Text(
                  'Lorem Ipsum is the best thing yeyLorem Ipsum is the best thing yey',
                  style: smallTextRed,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.white,
          thickness: 1,
        )
      ]),
    );
  }
}
