import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';

class Weightlinechart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.all(10),
      height: size.height * 0.5,
      width: double.infinity,
      child: LineChart(
        LineChartData(
            backgroundColor: kprimaryColor,
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(spots: [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 10),
                FlSpot(3, 7),
                FlSpot(4, 12),
              ])
            ]),
      ),
    );
  }
}
