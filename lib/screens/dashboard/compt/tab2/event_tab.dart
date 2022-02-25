import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/datahandeler/event_handaer.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';
import 'package:pet1/screens/components/popup_dilog.dart';

import 'events/edit_event_screen.dart';
import 'events/input_event_screen.dart';

class EventTab extends StatefulWidget {
  final String petname;

  const EventTab({Key? key, required this.petname}) : super(key: key);
  @override
  _EventTabState createState() => _EventTabState();
}

class _EventTabState extends State<EventTab> {
  late Future<List<EventModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FireDBHandeler.getallEvents();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
            elevation: 0.0,
            label: Text("Create event"),
            icon: Icon(Icons.add),
            backgroundColor: kprimaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InputEvent(
                            petname: widget.petname,
                          ))).then((val) => val ? loaddata() : null);
            }),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.1, bottom: size.width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LineIcon.calendarAlt(
                      size: size.width * 0.09,
                      color: Colors.deepPurple.shade500,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      "Events",
                      style: TextStyle(
                          fontSize: size.width * 0.08,
                          color: Colors.deepPurple.shade500),
                    ),
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
                        List<EventModel> data =
                            snapshot.data as List<EventModel>;
                        print(data);
                        if (data.isEmpty) {
                          return Center(
                              child: Lottie.asset(
                                  "assets/animations/emptybox.json",
                                  width: size.width * 0.3)); //nodatafound.json
                        } else {
                          return Container(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, indext) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.02,
                                        right: size.width * 0.02),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: data[indext].status == 0
                                          ? kmenucolor
                                          : Colors.blueGrey,
                                      child: GestureDetector(
                                        onTap: () {
                                          print(indext);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditEvent(
                                                        eventModel:
                                                            data[indext],
                                                        petname: widget.petname,
                                                      ))).then(
                                              (val) => val ? loaddata() : null);
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
                                              child: Icon(
                                                  Icons.event_note_rounded,
                                                  color: Colors.white),
                                            ),
                                            title: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    data[indext].title,
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
                                                Text(" remaining time",
                                                    style: TextStyle(
                                                        color: Colors.white))
                                              ],
                                            ),
                                            trailing: GestureDetector(
                                              onTap: data[indext].status == 0
                                                  ? () async {
                                                      PopupDialog.showPopupDilog(
                                                          context,
                                                          "Hello",
                                                          "Did you done this event ?",
                                                          () async {
                                                        EventModel event =
                                                            data[indext];
                                                        event.status = 1;
                                                        int res =
                                                            await FireDBHandeler
                                                                .updateEvent(
                                                                    event);
                                                        if (res == 0) {
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
                                              child: data[indext].status == 0
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
                        return Text("${snapshot.error}");
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
    futureData = FireDBHandeler.getallEvents();
    setState(() {});
  }
}
