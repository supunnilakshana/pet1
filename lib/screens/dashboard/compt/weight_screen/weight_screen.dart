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
import 'weight_chart.dart';

class WeightScreen extends StatefulWidget {
  // final List<Weight> weights;
  final String petname;
  final Function() reloadbutton;

  const WeightScreen(
      {Key? key, required this.petname, required this.reloadbutton})
      : super(key: key);

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  late Future<List<Weight>> futureData;

  @override
  void initState() {
    futureData = FireDBHandeler.geteWeight(widget.petname);
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
                    widget.petname + "'s Weights",
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
                            List<Weight> data = snapshot.data as List<Weight>;
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
                                  Text('Weight(Kg)',
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
                                        child: Text(element.value.toString(),
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
                                                      List<Weight> tempdata =
                                                          data;
                                                      print(tempdata.length);
                                                      tempdata.removeWhere(
                                                          (item) =>
                                                              item.id ==
                                                              element.id);
                                                      print(tempdata.length);
                                                      int res =
                                                          await FireDBHandeler
                                                              .updateWeightlist(
                                                                  widget
                                                                      .petname,
                                                                  tempdata);
                                                      // int res = 1;

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
                                              color: Colors.blueGrey
                                                  .withOpacity(0.8),
                                            )))
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
                                        top: size.height * 0.05,
                                        bottom: size.height * 0.05),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 0.05))),
                                        child: Container(
                                            width: size.width,
                                            height: size.height * 0.45,
                                            child: BarchartWeight(
                                              seriesList: BarchartWeight
                                                  .createSampleData(data),
                                            ))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05,
                                        right: size.width * 0.05,
                                        bottom: size.height * 0.05),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.pink.shade100,
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
                                      "assets/animations/createinimation.json",
                                      width: size.width * 0.75),
                                  Text(
                                    "Add you pet weight!!",
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
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "new weight",
            style: TextStyle(fontSize: size.width * 0.05),
          ),
          onPressed: () {
            WeightInput.popupWeight(context, widget.petname, () {
              loaddata();
              widget.reloadbutton();
            });
          },
          tooltip: 'Increment',
          backgroundColor: Colors.deepPurpleAccent,
          icon: Icon(Icons.add),
        ),
      )),
    );
  }

  loaddata() {
    futureData = FireDBHandeler.geteWeight(widget.petname);

    setState(() {});
  }
}
