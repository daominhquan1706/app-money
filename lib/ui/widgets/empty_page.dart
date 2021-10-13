import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.note,
          size: 200,
          color: Colors.black26,
        ),
      ),
    );
  }
}
