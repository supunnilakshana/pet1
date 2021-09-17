import 'package:flutter/material.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/progressindicaror_circle.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';

class ProgressArea extends StatefulWidget {
  final String petname;

  const ProgressArea({Key? key, required this.petname}) : super(key: key);
  @override
  _ProgressAreaState createState() => _ProgressAreaState();
}

class _ProgressAreaState extends State<ProgressArea> {
  CircelProgressHandeler c = CircelProgressHandeler();
  CircelProgress weight = CircelProgress();
  CircelProgress bath = CircelProgress();
  CircelProgress hair = CircelProgress();
  CircelProgress teeth = CircelProgress();
  CircelProgress workout = CircelProgress();
  PetdbHandeler pd = PetdbHandeler();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: kprimarylightcolor),
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          Row(children: <Widget>[
            GestureDetector(
              onTap: () {
                PopupDialog.showPopupDilog(
                    context, "Bath", "Was your pet bathe Today ? ", () async {
                  await pd.setBath(widget.petname);
                  print("adeed bath");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dasboard(
                                petname: widget.petname,
                              )));
                  print(widget.petname + "----------------------");
                });
              },
              child: ProgreesCricle(
                centerText: Text(
                  bath.centerText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                footerText: Text(
                  "Bath",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                progresscolor: bath.color,
                precentage: bath.progress,
              ),
            ),
            ProgreesCricle(
              centerText: Text(
                "Tap",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              footerText: Text(
                "Weight",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              progresscolor: Colors.white54,
              precentage: 0,
            ),
            GestureDetector(
              onTap: () {
                PopupDialog.showPopupDilog(
                    context, "Work out", "Was your pet workout Today ? ",
                    () async {
                  await pd.setWorkout(widget.petname);
                  print("adeed workout");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dasboard(
                                petname: widget.petname,
                              )));
                  print(widget.petname + "----------------------");
                });
              },
              child: ProgreesCricle(
                centerText: Text(
                  workout.centerText,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                footerText: Text(
                  "Work out",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                progresscolor: workout.color,
                precentage: workout.progress,
              ),
            )
          ]),
          Row(children: <Widget>[
            GestureDetector(
              onTap: () {
                PopupDialog.showPopupDilog(
                    context, "Hair", "Was your pet hair Today ? ", () async {
                  await pd.setHair(widget.petname);
                  print("adeed hair");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dasboard(
                                petname: widget.petname,
                              )));
                  print(widget.petname + "----------------------");
                });
              },
              child: ProgreesCricle(
                centerText: Text(
                  hair.centerText,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                footerText: Text(
                  "Hair",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                progresscolor: hair.color,
                precentage: hair.progress,
              ),
            ),
            GestureDetector(
              onTap: () {
                PopupDialog.showPopupDilog(
                    context, "Teeth", "Was your pet brush Today ? ", () async {
                  await pd.setTeeth(widget.petname);
                  print("adeed brush");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dasboard(
                                petname: widget.petname,
                              )));
                  print(widget.petname + "----------------------");
                });
              },
              child: ProgreesCricle(
                centerText: Text(
                  teeth.centerText,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                footerText: Text(
                  "Teeth",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                progresscolor: teeth.color,
                precentage: teeth.progress,
              ),
            ),
            ProgreesCricle(
              centerText: Text(
                "1/3",
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
    // weight = await c.weightprogress(widget.petname);
    bath = await c.bathtprogress(widget.petname);
    hair = await c.hairprogress(widget.petname);
    teeth = await c.teethProgress(widget.petname);
    workout = await c.workoutProgress(widget.petname);

    setState(() {});

    print(bath.centerText);
    print("--------------....................-------------");
  }
}
