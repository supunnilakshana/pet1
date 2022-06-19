import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/pet_list.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/errorpage.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/tots.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/vaccines/compt/vaccine_input.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/weight_input.dart';
import 'package:pet1/screens/dashboard/compt/weight_screen/weighbar_chart.dart';

import 'backgound.dart';

class SingelVaccineScreen extends StatefulWidget {
  // final Vaccine weights;
  final String petname;
  final String docid;
  final Function() reloadbutton;

  const SingelVaccineScreen(
      {Key? key,
      required this.petname,
      required this.reloadbutton,
      required this.docid})
      : super(key: key);

  @override
  _SingelVaccineScreenState createState() => _SingelVaccineScreenState();
}

class _SingelVaccineScreenState extends State<SingelVaccineScreen> {
  late Future<Vaccine> futureData;
  late VaccinedesItem dataitem;

  @override
  void initState() {
    futureData = FireDBHandeler.getVaccine(widget.petname, widget.docid);
    dataitem = vaccineList[int.parse(widget.docid)];
    super.initState();
  }

  bool candelete = true;
  bool load = false;
  late Vaccine initdata;

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
                    dataitem.name,
                    style: TextStyle(
                        fontSize: size.width * 0.08, color: kheadingcolorlight),
                  ),
                  Padding(
                      padding: EdgeInsets.only(),
                      child: Container(
                          child: FutureBuilder(
                        future: futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Vaccine vaccinedata = snapshot.data as Vaccine;
                            load = true;
                            initdata = vaccinedata;
                            List<VaccineSub> data = vaccinedata.vaccinelist;
                            data.sort((a, b) => b.dateTime.compareTo(a.id));
                            List<TableRow> trlist = [];

                            trlist.add(TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text('Date',
                                      style: TextStyle(
                                          fontSize: size.width * 0.055,
                                          fontWeight: FontWeight.w700))
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text('Dose',
                                      style: TextStyle(
                                          fontSize: size.width * 0.055,
                                          fontWeight: FontWeight.w700))
                                ]),
                              ),
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
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(element.dose.toString(),
                                            style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                            onTap: candelete
                                                ? () async {
                                                    PopupDialog.showPopupWarning(
                                                        context,
                                                        'Are you sure to delete?',
                                                        "weight date:" +
                                                            element.dateTime,
                                                        () async {
                                                      List<VaccineSub>
                                                          tempdata = data;
                                                      print(tempdata.length);
                                                      tempdata.removeWhere(
                                                          (item) =>
                                                              item.id ==
                                                              element.id);
                                                      print(tempdata.length);
                                                      int res = await FireDBHandeler
                                                          .updateVaccinelist(
                                                              widget.petname,
                                                              tempdata,
                                                              widget.docid,
                                                              vaccinedata
                                                                  .vitNextDate,
                                                              vaccinedata.dose);

                                                      // // int res = 1;

                                                      if (res == 1) {
                                                        Customtost.commontost(
                                                            "Succefully deleted",
                                                            Colors.greenAccent);
                                                      } else {
                                                        Customtost.commontost(
                                                            "Somthing went wrong",
                                                            Colors.redAccent);
                                                      }
                                                      loaddata();
                                                      widget.reloadbutton();
                                                    });
                                                  }
                                                : null,
                                            child: Icon(
                                              Icons.delete,
                                              color:
                                                  Colors.red.withOpacity(0.8),
                                            )))
                                  ]),
                                ),
                              ]));
                            });

                            if (data.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.05,
                                          left: size.width * 0.05,
                                          right: size.width * 0.05,
                                          bottom: size.height * 0.05),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.indigoAccent.shade100,
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
                                      height: size.height * 0.0,
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                        "assets/animations/createinimation.json",
                                        width: size.width * 0.2),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Add you pet vaccination deatails!!",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.width * 0.05,
                                            color: kheadingcolorlight),
                                      ),
                                    ),
                                  ],
                                ),
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
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "What is " + dataitem.name + "?",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.05,
                          color: kheadingcolorlight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                      ),
                      child: ClipRRect(
                          child: Image.asset(dataitem.imgurl),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.05))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dataitem.description,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: size.width * 0.04),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Add Vaccination",
            style: TextStyle(fontSize: size.width * 0.05),
          ),
          onPressed: load
              ? () {
                  VaccineInput.popupWeight(context, widget.petname, initdata,
                      () {
                    loaddata();
                    widget.reloadbutton();
                  });
                }
              : () {
                  Customtost.commontost("still loading", Colors.indigoAccent);
                },
          tooltip: 'Increment',
          backgroundColor: Colors.deepPurpleAccent,
          icon: Icon(Icons.add),
        ),
      )),
    );
  }

  loaddata() {
    futureData = FireDBHandeler.getVaccine(widget.petname, widget.docid);

    setState(() {});
  }
}
