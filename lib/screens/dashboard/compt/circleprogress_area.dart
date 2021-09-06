import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/screens/components/progressindicaror_circle.dart';

class ProgressArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var pethandeler = PetdbHandeler();

    return Container(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            ProgreesCricle(
              centerText: Text(
                "",
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
                "90.0%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Weight",
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
}
