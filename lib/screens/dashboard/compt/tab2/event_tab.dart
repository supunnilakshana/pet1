import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/datahandeler/event_handaer.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';

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
          decoration: BoxDecoration(color: klightbackgoundcolor),
          child: FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                List<EventModel> data = snapshot.data as List<EventModel>;
                print(data);
                if (data.isEmpty) {
                  return Center(
                      child: Lottie.asset("assets/animations/emptybox.json",
                          width: size.width * 0.3)); //nodatafound.json
                } else {
                  return Container(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, indext) {
                          return Card(
                            color: kmenucolor,
                            child: GestureDetector(
                              onTap: () {
                                print(indext);
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditEvent(
                                                  eventModel: data[indext],
                                                  petname: widget.petname,
                                                )))
                                    .then((val) => val ? loaddata() : null);
                              },
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.white24))),
                                    child: Icon(Icons.event_note_rounded,
                                        color: Colors.white),
                                  ),
                                  title: Text(
                                    data[indext].title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                  subtitle: Row(
                                    children: <Widget>[
                                      Icon(Icons.timer,
                                          color: Colors.yellowAccent),
                                      Text(" remaining time",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  trailing: Icon(Icons.done_rounded,
                                      color: Colors.white, size: 30.0)),
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
                  child: Lottie.asset("assets/animations/loadinghand.json",
                      width: size.width * 0.3));
            },
          ),
        ));
  }

  loaddata() async {
    futureData = FireDBHandeler.getallEvents();
    setState(() {});
  }
}
