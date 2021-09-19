import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(color: klightbackgoundcolor),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /* Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signin.png",
                width: size.width,
              )),*/
          child,
        ],
      ),
    );
  }
}
