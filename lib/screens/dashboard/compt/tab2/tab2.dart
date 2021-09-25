import 'package:flutter/material.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';
import 'package:pet1/screens/dashboard/compt/tab2/events/input_event_screen.dart';

import 'backgound.dart';

class Tab2 extends StatefulWidget {
  final String petname;

  const Tab2({Key? key, required this.petname}) : super(key: key);
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  List<Event> eventlist = [
    Event("titel 1", "This is description ", "2020/21/1", Date.getStringdate(),
        0),
    Event(
        "titel 2", "This is description", "2020/21/1", Date.getStringdate(), 0),
    Event(
        "titel 3", "This is description", "2020/21/1", Date.getStringdate(), 0),
    Event(
        "titel 2", "This is description", "2020/21/1", Date.getStringdate(), 0),
    Event(
        "titel 3", "This is description", "2020/21/1", Date.getStringdate(), 0),
    Event(
        "titel 2", "This is description", "2020/21/1", Date.getStringdate(), 0),
    Event(
        "titel 3", "This is description", "2020/21/1", Date.getStringdate(), 0),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: klightbackgoundcolor),
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.6,
                child: ListView.builder(
                    itemCount: eventlist.length,
                    itemBuilder: (context, indext) {
                      return Card(
                        color: kmenucolor,
                        child: GestureDetector(
                          onTap: () {
                            print(indext);
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
                                eventlist[indext].title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              subtitle: Row(
                                children: <Widget>[
                                  Icon(Icons.timer, color: Colors.yellowAccent),
                                  Text(" remaining time",
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white, size: 30.0)),
                        ),
                      );
                    }),
              ),
              Stack(
                alignment: FractionalOffset(0.7, 1.0),
                children: <Widget>[
                  new FloatingActionButton(
                      elevation: 0.0,
                      child: new Icon(Icons.add),
                      backgroundColor: kprimaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputEvent(
                                      petname: widget.petname,
                                    )));
                      })
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
