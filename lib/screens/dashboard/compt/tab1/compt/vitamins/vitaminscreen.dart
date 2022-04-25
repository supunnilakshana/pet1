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
import 'package:pet1/screens/dashboard/compt/tab1/compt/vitamins/addvitamin.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/vitamins/editvitamin.dart';

class VitaminScreen extends StatefulWidget {
  final String petname;

  const VitaminScreen({Key? key, required this.petname}) : super(key: key);
  @override
  _VitaminScreenState createState() => _VitaminScreenState();
}

class _VitaminScreenState extends State<VitaminScreen> {
  late Future<List<Vitamin>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FireDBHandeler.getallVitamin(widget.petname);
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
        floatingActionButton: FloatingActionButton.extended(
            elevation: 0.0,
            label: Text("Add a Vitamin"),
            icon: Icon(Icons.add),
            backgroundColor: kprimaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddVitamin(
                            petname: widget.petname,
                          ))).then((val) => val ? loaddata() : null);
            }),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.0, bottom: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LineIcon.medkit(
                      size: size.width * 0.08,
                      color: Colors.deepPurple.shade500,
                    ),
                    SizedBox(
                      width: size.width * 0.015,
                    ),
                    Text(
                      widget.petname + "' s Vitamins",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.width * 0.06,
                          color: Colors.deepPurple.shade500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.06),
                      child: Image.asset(
                        "assets/icons/medicalhistory.png",
                        width: size.width * 0.15,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        List<Vitamin> data = snapshot.data as List<Vitamin>;
                        print(data);
                        if (data.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                  "assets/animations/createinimation.json",
                                  width: size.width * 0.75),
                              Text(
                                "Create event & enjoy with pet",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.045,
                                    color: kheadingcolorlight),
                              ),
                            ],
                          ); //nodatafound.json
                        } else {
                          return Container(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, indext) {
                                  String d = "";
                                  String h = "";
                                  String m = "";
                                  RemainingTime remainingTime =
                                      Date.datetimeBetween(
                                          data[indext].vitNextDate,
                                          data[indext].vitNextTime);

                                  if (remainingTime.days != 0) {
                                    d = remainingTime.days.toString() + "days ";
                                  }
                                  if (remainingTime.hours != 0) {
                                    h = remainingTime.hours.toString() +
                                        " hours ";
                                  }
                                  if (remainingTime.minits != 0) {
                                    m = remainingTime.minits.toString() +
                                        "minitus ";
                                  }

                                  String remainintext = d + h + m;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.02,
                                        right: size.width * 0.02),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: data[indext].repatestatus == 1
                                          ? remainingTime.isoverdue
                                              ? Colors.red.shade400
                                              : kmenucolor
                                          : Colors.green.shade400,
                                      child: GestureDetector(
                                        onTap: () {
                                          print(indext);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditVitamin(
                                                        vitaminModel:
                                                            data[indext],
                                                        petname: widget.petname,
                                                      ))).then((val) =>
                                              val ? loaddata() : () {});
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
                                                  "assets/icons/vitaminbottel.png"),
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
                                                  child: Text(
                                                      data[indext].repatestatus ==
                                                              1
                                                          ? remainingTime
                                                                  .isoverdue
                                                              ? "Overdue " +
                                                                  remainintext
                                                              : "Remaining " +
                                                                  remainintext
                                                          : "Done",
                                                      overflow:
                                                          TextOverflow.clip,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                )
                                              ],
                                            ),
                                            trailing: GestureDetector(
                                              onTap: data[indext]
                                                          .repatestatus ==
                                                      1
                                                  ? () async {
                                                      PopupDialog.showPopupDilog(
                                                          context,
                                                          "Hello",
                                                          "Did you give vitamins ?",
                                                          () async {
                                                        String nextvitdate =
                                                            data[indext]
                                                                .vitNextDate;
                                                        String nextvittime =
                                                            data[indext]
                                                                .vitNextTime;
                                                        print(nextvitdate +
                                                            "-----------" +
                                                            nextvittime);
                                                        if (data[indext]
                                                                .repatetype ==
                                                            "D") {
                                                          var cdate = DateFormat(
                                                                  'd/M/y')
                                                              .parse(data[
                                                                      indext]
                                                                  .vitNextDate);
                                                          var newdate = DateTime(
                                                              cdate.year,
                                                              cdate.month,
                                                              cdate.day +
                                                                  data[indext]
                                                                      .repatecount);
                                                          nextvitdate = DateFormat(
                                                                  "dd/MM/yyyy")
                                                              .format(newdate)
                                                              .toString();
                                                        } else if (data[indext]
                                                                .repatetype ==
                                                            "H") {
                                                          var cdatetime = DateFormat(
                                                                  'd/M/y hh:mm a')
                                                              .parse(data[indext]
                                                                      .vitNextDate +
                                                                  " " +
                                                                  data[indext]
                                                                      .vitNextTime);
                                                          print(cdatetime);
                                                          var newdatetime = DateTime(
                                                              cdatetime.year,
                                                              cdatetime.month,
                                                              cdatetime.day,
                                                              cdatetime.hour +
                                                                  data[indext]
                                                                      .repatecount,
                                                              cdatetime.minute);
                                                          nextvittime =
                                                              DateFormat.jm()
                                                                  .format(
                                                                      newdatetime)
                                                                  .toString();
                                                        } else {}
                                                        print(nextvitdate +
                                                            "-----------" +
                                                            nextvittime);

                                                        Vitamin vitaminmodel =
                                                            data[indext];

                                                        vitaminmodel
                                                                .vitNextDate =
                                                            nextvitdate;
                                                        vitaminmodel
                                                                .vitNextTime =
                                                            nextvittime;
                                                        int res =
                                                            await FireDBHandeler
                                                                .updateVitamin(
                                                                    vitaminmodel,
                                                                    widget
                                                                        .petname);
                                                        VitaminHistoryModel
                                                            vitaminHistoryModel =
                                                            VitaminHistoryModel(
                                                                id: Date
                                                                    .getDateTimeId(),
                                                                dateTime:
                                                                    nextvitdate +
                                                                        " " +
                                                                        nextvittime,
                                                                vitaminid:
                                                                    data[indext]
                                                                        .id,
                                                                vitaminname:
                                                                    data[indext]
                                                                        .name);
                                                        int hisres =
                                                            await FireDBHandeler
                                                                .updateVitHistory(
                                                                    widget
                                                                        .petname,
                                                                    vitaminHistoryModel);

                                                        if (res == 0 &&
                                                            res == 0) {
                                                          loaddata();
                                                          Fluttertoast.showToast(
                                                              msg: "Done",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              backgroundColor:
                                                                  Colors.green,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Updating is failed",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                        }
                                                      });
                                                    }
                                                  : null,
                                              child: data[indext]
                                                          .repatestatus ==
                                                      1
                                                  ? Icon(Icons.done_rounded,
                                                      color:
                                                          Colors.yellowAccent,
                                                      size: size.width * 0.08)
                                                  : Icon(Icons.check_circle,
                                                      color: Colors
                                                          .yellow.shade500,
                                                      size: size.width * 0.08),
                                            )),
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

  loaddata() async {
    futureData = FireDBHandeler.getallVitamin(widget.petname);
    setState(() {});
  }
}
