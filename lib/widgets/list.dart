import 'package:flutter/material.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record.dart';
import 'package:money_app/model/record_section.dart';
import 'package:money_app/widgets/headerview.dart';
import 'package:money_app/widgets/itemview.dart';

class MyList extends StatelessWidget {
  final List<Record> listRecord;
  final pageController = PageController();

  MyList({Key key, @required this.listRecord}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var listDate = listRecord
        .map((e) =>
            DateTime(e.createDate.year, e.createDate.month, e.createDate.day))
        .toSet()
        .toList();
    var sections = listDate
        .map((date) => RecordSection(
            date: date,
            list: listRecord
                .where((r) =>
                    DateTime.utc(r.createDate.year, r.createDate.month,
                        r.createDate.day) ==
                    DateTime.utc(date.year, date.month, date.day))
                .toList()))
        .toList();

    return Container(
      color: Colors.grey.shade200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildReportView(),
            ...sections.map((e) => RecordView(section: e)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportView() {
    final inputAmount = listRecord
        .where((element) => element.isAdd)
        .map((e) => e.amount)
        .reduce((a, b) => a + b);
    final outputAmount = listRecord
        .where((element) => !element.isAdd)
        .map((e) => e.amount)
        .reduce((a, b) => a + b);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text("Money input"),
                Spacer(),
                Text(
                  StringHelper.getMoneyText(inputAmount),
                  style: TextStyle(color: Colors.blue),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text("Money output"),
                Spacer(),
                Text(
                  StringHelper.getMoneyText(outputAmount),
                  style: TextStyle(color: Colors.red),
                )
              ]),
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  width: 100,
                  height: 1,
                  color: Colors.black26,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text(""),
                Spacer(),
                Text(StringHelper.getMoneyText(inputAmount - outputAmount))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordView extends StatelessWidget {
  final RecordSection section;

  const RecordView({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderView(
            date: section.date,
            amount: section.sumAmount(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: section.list.map((e) => ItemView(record: e)).toList(),
          ),
        ],
      ),
    );
  }
}
