import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)
class PieChartSample3 extends StatefulWidget {
  final double inputAmount;
  final double outputAmount;
  const PieChartSample3(
      {Key key, @required this.inputAmount, @required this.outputAmount})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
              setState(() {
                if (pieTouchResponse.touchInput is FlLongPressEnd ||
                    pieTouchResponse.touchInput is FlPanEnd) {
                  touchedIndex = -1;
                } else {
                  touchedIndex = pieTouchResponse.touchedSectionIndex;
                }
              });
            }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 1,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;
      final Color inputColor = Colors.green;
      final Color outputColor = Colors.redAccent;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: inputColor,
            value: widget.inputAmount,
            title: '${widget.inputAmount.round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'https://www.svgrepo.com/show/255984/input.svg',
              size: widgetSize,
              borderColor: inputColor,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: outputColor,
            value: widget.outputAmount,
            title: '${widget.outputAmount.round()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'https://www.svgrepo.com/show/255981/output.svg',
              size: widgetSize,
              borderColor: outputColor,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          return null;
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key key,
    @required this.size,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.network(svgAsset),
      ),
    );
  }
}
