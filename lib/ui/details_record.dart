import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record.dart';

class DetailsRecord extends StatefulWidget {
  final Record record;

  const DetailsRecord({Key key, this.record}) : super(key: key);

  @override
  _DetailsRecordState createState() => _DetailsRecordState();
}

class _DetailsRecordState extends State<DetailsRecord> {
  @override
  Widget build(BuildContext context) {
    final record = widget.record;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: Icon(Icons.delete), onPressed: () {}),
        ],
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(record.title),
              leading: CircleAvatar(),
            ),
            ListTile(
              title: Text(
                "${StringHelper.getMoneyText(record.amount)} đ",
                style:
                    TextStyle(color: record.isAdd ? Colors.blue : Colors.red),
              ),
              leading: SizedBox.shrink(),
            ),
            ListTile(
              title: Text(record.note),
              leading: Icon(Icons.note),
            ),
            ListTile(
              title: Text(
                  "${DateFormat('EEEE, d/M/yyyy').format(record.createDate)}"),
              leading: Icon(Icons.calendar_today_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
