import 'package:flutter/material.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/screens/components/progressindicaror_circle.dart';

class ProgressArea extends StatefulWidget {
  @override
  _ProgressAreaState createState() => _ProgressAreaState();
}

class _ProgressAreaState extends State<ProgressArea> {
  CircelProgressHandeler c = CircelProgressHandeler();
  CircelProgress? weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            ProgreesCricle(
              centerText: Text(
                're',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Bath",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.green,
              precentage: 0.6,
            ),
            ProgreesCricle(
              centerText: Text(
                weight!.centerText,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                weight!.footerText,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.amberAccent,
              precentage: weight!.progress,
            ),
            ProgreesCricle(
              centerText: Text(
                "40.0%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Work out",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.lightBlue,
              precentage: 0.4,
            )
          ]),
          Row(children: <Widget>[
            ProgreesCricle(
              centerText: Text(
                "60.0%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Hair",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.green,
              precentage: 0.6,
            ),
            ProgreesCricle(
              centerText: Text(
                "90.0%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Teeth",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.amberAccent,
              precentage: 0.9,
            ),
            ProgreesCricle(
              centerText: Text(
                "40.0%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Vaccine",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.lightBlue,
              precentage: 0.4,
            ),
          ]),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    weight = await c.weightprogress();
    print("--------------....................-------------");
    setState(() {});
  }
}
