import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/errorpage.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/tots.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/weight_input.dart';
import 'package:pet1/screens/dashboard/compt/weight_screen/weighbar_chart.dart';

import 'backgound.dart';

class VaccineHistoryScreen extends StatefulWidget {
  // final List<Weight> weights;
  final String petname;
  final Function() reloadbutton;

  const VaccineHistoryScreen(
      {Key? key, required this.petname, required this.reloadbutton})
      : super(key: key);

  @override
  _VaccineHistoryScreenState createState() => _VaccineHistoryScreenState();
}

class _VaccineHistoryScreenState extends State<VaccineHistoryScreen> {
  late Future<List<VaccineHisotryItem>> futureData;

  @override
  void initState() {
    futureData = FireDBHandeler.getVaccineHistory(widget.petname);
    super.initState();
  }

  bool candelete = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Background(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView(
          children: [
            Container(
              width: size.width,
              child: Column(
                children: <Widget>[
                  Text(
                    " Vaccination History",
                    style: TextStyle(
                        fontSize: size.width * 0.08, color: kheadingcolorlight),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: Container(
                          child: FutureBuilder(
                        future: futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<VaccineHisotryItem> data =
                                snapshot.data as List<VaccineHisotryItem>;
                            List<TableRow> trlist = [];

                            trlist.add(TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text('Date',
                                      style: TextStyle(
                                          fontSize: size.width * 0.05,
                                          fontWeight: FontWeight.w500))
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text('Name & Dose',
                                      style: TextStyle(
                                          fontSize: size.width * 0.05,
                                          fontWeight: FontWeight.w500))
                                ]),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(children: [
                              //     Text('Does',
                              //         style: TextStyle(
                              //             fontSize: size.width * 0.055,
                              //             fontWeight: FontWeight.w700))
                              //   ]),
                              // ),
                            ]));
                            data.forEach((element) {
                              trlist.add(TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    Text(element.dateTime,
                                        style: TextStyle(
                                            fontSize: size.width * 0.045,
                                            fontWeight: FontWeight.w500))
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(element.vname,
                                            style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(element.dose.toString(),
                                            style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    )
                                  ]),
                                ),
                              ]));
                            });

                            if (data.isNotEmpty) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05,
                                        right: size.width * 0.05,
                                        bottom: size.height * 0.05),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 0.05))),
                                      child: Table(
                                          border: TableBorder.all(
                                              color: Colors.white,
                                              style: BorderStyle.none,
                                              width: 2),
                                          children: trlist),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.06,
                                  )
                                ],
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                      "assets/animations/historyno.json",
                                      width: size.width * 0.75),
                                  Text(
                                    "No Vaccination History!!",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * 0.05,
                                        color: kheadingcolorlight),
                                  ),
                                ],
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
                      )))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  loaddata() {
    futureData = FireDBHandeler.getVaccineHistory(widget.petname);

    setState(() {});
  }
}
