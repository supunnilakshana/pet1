import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgreesCricle extends StatelessWidget {
  final Text centerText;
  final Text footerText;
  final Color progresscolor;
  final double precentage;
  const ProgreesCricle({
    Key? key,
    required this.centerText,
    required this.footerText,
    required this.progresscolor,
    required this.precentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(size.width * 0.04),
      child: CircularPercentIndicator(
        radius: size.width * 0.25,
        lineWidth: size.width * 0.025,
        animation: true,
        percent: precentage,
        center: centerText,
        footer: footerText,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: progresscolor,
      ),
    );
  }
}
