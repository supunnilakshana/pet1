import 'package:flutter/material.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/weight_input.dart';

import 'backgound.dart';
import 'weight_chart.dart';

class WeightScreen extends StatelessWidget {
  final List<Weight> weights;
  final String petname;

  const WeightScreen({Key? key, required this.weights, required this.petname})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Background(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Weight"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0,
              ),
              Container(
                  width: size.width,
                  height: size.height * 0.45,
                  child: BarChartSample2(
                    weights: weights,
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            WeightInput.popupWeight(context, petname);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      )),
    );
  }
}
