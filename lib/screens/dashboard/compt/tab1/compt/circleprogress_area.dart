import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/progressindicaror_circle.dart';
import 'package:pet1/screens/components/tots.dart';

class ProgressArea extends StatefulWidget {
  final String petname;

  const ProgressArea({Key? key, required this.petname}) : super(key: key);
  @override
  _ProgressAreaState createState() => _ProgressAreaState();
}

class _ProgressAreaState extends State<ProgressArea> {
  late Future<PetDayActivity> futureData;
  late CircelProgress bath;
  late CircelProgress teeth;
  late CircelProgress hair;
  late CircelProgress workout;
   @override
  initState() {
    futureData = FireDBHandeler.getdayActivity(widget.petname);
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle centertextstyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.04);
    TextStyle footertextstyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.048);
    return Container(
      width: size.width,
      decoration: BoxDecoration(),
      child: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            PetDayActivity data = snapshot.data as PetDayActivity;
            print(data);
            loadcomponent(data);

            return Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Row(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        PopupDialog.showPopupDilog(
                            context, "Bath", "Was your pet bathe Today ? ",
                            () async {
                          int res = await FireDBHandeler.updatedayActivity(
                              "bath", widget.petname);
                          print("adeed bath");
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Dasboard(
                          //               petname: widget.petname,
                          //             )));
                          if (res == 1) {
                            Customtost.commontost(
                                "Sucessfully Updated", Colors.green);
                          } else {
                            Customtost.commontost(
                                "Updated fail", Colors.redAccent);
                          }
                          // Navigator.of(context).pop();
                          loadData();
                          print(widget.petname + "----------------------");
                        });
                      },
                      child: ProgreesCricle(
                        centerText: Text(
                          bath.centerText,
                          style: centertextstyle,
                        ),
                        footerText: Text(
                          "Bath",
                          style: footertextstyle,
                        ),
                        progresscolor: bath.color,
                        precentage: bath.progress,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        PopupDialog.showPopupDilog(
                            context, "Teeth", "Was your pet brush Today ? ",
                            () async {
                          int res = await FireDBHandeler.updatedayActivity(
                              "teeth", widget.petname);
                          print("adeed teeth");
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Dasboard(
                          //               petname: widget.petname,
                          //             )));
                          if (res == 1) {
                            Customtost.commontost(
                                "Sucessfully Updated", Colors.green);
                          } else {
                            Customtost.commontost(
                                "Updated fail", Colors.redAccent);
                          }
                          // Navigator.of(context).pop();
                          loadData();
                          print(widget.petname + "----------------------");
                        });
                      },
                      child: ProgreesCricle(
                        centerText: Text(
                          teeth.centerText,
                          style: centertextstyle,
                        ),
                        footerText: Text(
                          "Teeth",
                          style: footertextstyle,
                        ),
                        progresscolor:teeth.color,
                        precentage: teeth.progress,
                      ),
                    ),
                    
                  ]),
                  Row(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        PopupDialog.showPopupDilog(
                            context, "Hair", "Was your pet hair Today ? ",
                            () async {
                          int res = await FireDBHandeler.updatedayActivity(
                              "hair", widget.petname);
                          print("adeed hair");
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Dasboard(
                          //               petname: widget.petname,
                          //             )));
                          if (res == 1) {
                            Customtost.commontost(
                                "Sucessfully Updated", Colors.green);
                          } else {
                            Customtost.commontost(
                                "Updated fail", Colors.redAccent);
                          }
                          // Navigator.of(context).pop();
                          loadData();
                          print(widget.petname + "----------------------");
                        });
                      },
                      child: ProgreesCricle(
                        centerText: Text(
                          hair.centerText,
                          style: centertextstyle,
                        ),
                        footerText: Text(
                          "Hair",
                          style: footertextstyle,
                        ),
                        progresscolor:hair.color,
                        precentage: hair.progress,
                      ),
                    ),
                     GestureDetector(
                      onTap: () {
                        PopupDialog.showPopupDilog(
                            context, "Work-out", "Was your pet workout Today ? ",
                            () async {
                          int res = await FireDBHandeler.updatedayActivity(
                              "workout", widget.petname);
                          print("adeed workout");
                          
                          if (res == 1) {
                            Customtost.commontost(
                                "Sucessfully Updated", Colors.green);
                          } else {
                            Customtost.commontost(
                                "Updated fail", Colors.redAccent);
                          }
                          // Navigator.of(context).pop();
                          loadData();
                          print(widget.petname + "----------------------");
                        });
                      },
                      child: ProgreesCricle(
                        centerText: Text(
                          workout.centerText,
                          style: centertextstyle,
                        ),
                        footerText: Text(
                          "Work-out",
                          style: footertextstyle,
                        ),
                        progresscolor: workout.color,
                        precentage: workout.progress,
                      ),
                    ),
                  ]),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Lottie.asset("assets/animations/error.json",
                    width: size.width * 0.75));
          }
          // By default show a loading spinner.
          return Center(
              child: Lottie.asset("assets/animations/loadinghand.json",
                  width: size.width * 0.75));
        },
      ),
    );
  }

 

  loadcomponent(PetDayActivity data) {
    bath = CircelProgressHandeler.bathtprogress(data.bath);
    hair = CircelProgressHandeler.bathtprogress(data.hair);
    workout = CircelProgressHandeler.bathtprogress(data.workout);
    teeth = CircelProgressHandeler.bathtprogress(data.teeth);
    // setState(() {});
  }

  loadData() {
    futureData = FireDBHandeler.getdayActivity(widget.petname);
    setState(() {});
  }
}
