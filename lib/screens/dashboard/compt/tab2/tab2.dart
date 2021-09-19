import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';

import 'backgound.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.58,
              ),
              Stack(
                alignment: FractionalOffset(0.5, 1.0),
                children: <Widget>[
                  new FloatingActionButton(
                      elevation: 0.0,
                      child: new Icon(Icons.add),
                      backgroundColor: kprimaryColor,
                      onPressed: () {})
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
