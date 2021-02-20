import 'package:flutter/material.dart';
import 'package:money_app/widgets/pie_chart.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Page"),
      ),
      body: Center(
        child: PieChartSample3(),
      ),
    );
  }
}
