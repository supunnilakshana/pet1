import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocalIcon({
    Key? key,
    this.iconSrc = "assets/icons/facebook.svg",
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          iconSrc,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
