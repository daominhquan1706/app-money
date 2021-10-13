import 'package:flutter/material.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/ui/widgets/pie_chart.dart';

class ReportBody extends StatelessWidget {
  ReportBody({Key key, @required this.listRecord}) : super(key: key);
  final List<Record> listRecord;
  double inputAmount;
  double outputAmount;
  @override
  Widget build(BuildContext context) {
    if (listRecord.isEmpty) {
      return Container();
    }
    inputAmount = [
      ...listRecord.where((element) => element.isAdd).map((e) => e.amount),
      0.0
    ].reduce((a, b) => a + b);
    outputAmount = [
      ...listRecord.where((element) => !element.isAdd).map((e) => e.amount),
      0.0
    ].reduce((a, b) => a + b);

    return Column(
      children: [
        _buildReportView(),
        Expanded(child: _buildChart()),
      ],
    );
  }

  Widget _buildReportView() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.green,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Money input"),
                ),
                const Spacer(),
                Text(
                  StringHelper.instance.getMoneyText(inputAmount),
                  style: const TextStyle(color: Colors.green),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.redAccent,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Money ouput"),
                ),
                const Spacer(),
                Text(
                  StringHelper.instance.getMoneyText(outputAmount),
                  style: const TextStyle(color: Colors.red),
                )
              ]),
            ),
            Row(
              children: [
                const Spacer(),
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
                const Text(""),
                const Spacer(),
                Text(StringHelper.instance
                    .getMoneyText(inputAmount + outputAmount))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    final double sumAmount = inputAmount - outputAmount;
    final double inputPercent =
        ((inputAmount / sumAmount) * 100).round().toDouble();
    final double outputPercent = 100 - inputPercent;
    return Card(
      child: PieChartSample3(
        inputAmount: inputPercent,
        outputAmount: outputPercent,
      ),
    );
  }
}
