import 'package:flutter/material.dart';

import 'backgound.dart';

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0,
              ),
              Container()
            ],
          ),
        ),
      )),
    );
  }
}
