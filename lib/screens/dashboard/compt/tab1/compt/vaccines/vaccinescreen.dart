import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/datahandeler/event_handaer.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';
import 'package:pet1/screens/components/errorpage.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/vaccines/compt/vaccineHistory_screen.dart';

import 'compt/singelvaccine_screen.dart';

class VaccineScreen extends StatefulWidget {
  final String petname;

  const VaccineScreen({Key? key, required this.petname}) : super(key: key);
  @override
  _VaccineScreenState createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  late Future<List<Vaccine>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FireDBHandeler.getallVaccine(widget.petname);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.0, bottom: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.06),
                      child: Image.asset(
                        "assets/icons/vaccineiconnon.png",
                        width: size.width * 0.12,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.015,
                    ),
                    Text(
                      widget.petname + "' s Vaccines",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.width * 0.08,
                          color: Colors.deepPurple.shade500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VaccineHistoryScreen(
                                    petname: widget.petname,
                                    reloadbutton: () {})));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.deepPurpleAccent,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                              child: Text(
                                "Vaccination History",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.05,
                                    color: Colors.white),
                              ),
                            ),
                            Lottie.asset(
                              "assets/animations/history.json",
                            ),
                          ],
                        ),
                      ),
                    )),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.teal,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: Text(
                                    "Guildlines",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: size.width * 0.05,
                                        color: Colors.white),
                                  ),
                                ),
                                Lottie.asset(
                                  "assets/animations/guideline.json",
                                )
                              ],
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Vaccines List",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.05,
                      color: kheadingcolorlight),
                ),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        List<Vaccine> data = snapshot.data as List<Vaccine>;
                        print(data);
                        if (data.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Errorpage(size: size.width * 0.5)],
                          ); //nodatafound.json
                        } else {
                          return Container(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, indext) {
                                  // String d = "";
                                  // String h = "";
                                  // String m = "";
                                  // RemainingTime remainingTime =
                                  //     Date.datetimeBetween(
                                  //         data[indext].vitNextDate,
                                  //         data[indext].vitNextTime);

                                  // if (remainingTime.days != 0) {
                                  //   d = remainingTime.days.toString() + "days ";
                                  // }
                                  // if (remainingTime.hours != 0) {
                                  //   h = remainingTime.hours.toString() +
                                  //       " hours ";
                                  // }
                                  // if (remainingTime.minits != 0) {
                                  //   m = remainingTime.minits.toString() +
                                  //       "minitus ";
                                  // }

                                  String nextdatetext = "Not Vaccinated";
                                  if (data[indext].vitNextDate != "") {
                                    nextdatetext =
                                        "Next " + data[indext].vitNextDate;
                                  }

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.02,
                                        right: size.width * 0.02),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: colorList[indext],
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SingelVaccineScreen(
                                                          docid:
                                                              data[indext].id,
                                                          reloadbutton: () {},
                                                          petname:
                                                              widget.petname)));
                                        },
                                        child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 10.0),
                                            leading: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12.0),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              Colors.white24))),
                                              child: Image.asset(
                                                  "assets/icons/vaccineiconnon.png"),
                                            ),
                                            title: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    data[indext].name,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 0.05,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                            subtitle: Row(
                                              children: [
                                                Icon(Icons.timer,
                                                    color: Colors.yellowAccent),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                Expanded(
                                                  child: Text(nextdatetext,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                )
                                              ],
                                            ),
                                            trailing: GestureDetector(
                                                child: Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: Colors.yellowAccent,
                                                    size: size.width * 0.08))),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Errorpage(size: size.width * 0.7);
                      }
                      // By default show a loading spinner.
                      return Center(
                          child: Lottie.asset(
                              "assets/animations/loadingdots.json",
                              width: size.width * 0.6));
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  final colorList = [Colors.indigoAccent, Colors.green, Colors.purpleAccent];

  loaddata() async {
    futureData = FireDBHandeler.getallVaccine(widget.petname);
    setState(() {});
  }
}
