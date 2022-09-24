import 'package:flutter/cupertino.dart';
import 'package:moneylover/custom_colors.dart';
import 'package:moneylover/font_style.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatBubble({this.isSender = false, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isSender ? 10 : 0),
                          topRight: Radius.circular(isSender ? 0 : 10),
                          bottomLeft: const Radius.circular(10),
                          bottomRight: const Radius.circular(10)),
                      color: isSender ? chatBubble1 : lightOrange),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    text,
                    style: chatText,
                  )),
            )
          ]),
    );
  }
}
