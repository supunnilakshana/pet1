import 'package:flutter/material.dart';

import 'backgound.dart';
import 'weight_chart.dart';

class WeightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[Weightlinechart()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    ));
  }
}
