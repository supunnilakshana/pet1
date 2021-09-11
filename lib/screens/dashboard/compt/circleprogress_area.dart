import 'package:flutter/material.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/progressindicaror_circle.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';

class ProgressArea extends StatefulWidget {
  @override
  _ProgressAreaState createState() => _ProgressAreaState();
}

class _ProgressAreaState extends State<ProgressArea> {
  CircelProgressHandeler c = CircelProgressHandeler();
  CircelProgress weight = CircelProgress();
  CircelProgress bath = CircelProgress();
  CircelProgress hair = CircelProgress();
  PetdbHandeler pd = PetdbHandeler();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            GestureDetector(
              onTap: () {
                PopupDialog.showPopupDilog(
                    context, "Bath", "Was your pet bathe Today ? ", () async {
                  await pd.setBath("sukku");
                  print("adeed bath");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dasboard()));
                });
              },
              child: ProgreesCricle(
                centerText: Text(
                  're',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                footerText: Text(
                  "Bath",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                progresscolor: Colors.green,
                precentage: 0.6,
              ),
            ),
            ProgreesCricle(
              centerText: Text(
                weight.centerText,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                weight.footerText,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.amberAccent,
              precentage: weight.progress,
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
