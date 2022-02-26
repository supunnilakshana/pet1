import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          // image: DecorationImage(
          //   image: AssetImage("assets/images/petback.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            child,
          ],
        ),
      ),
    );
  }
}
