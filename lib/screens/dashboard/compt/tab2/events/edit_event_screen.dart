import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet1/controllers/datahandeler/event_handaer.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EditEvent extends StatefulWidget {
  final String petname;
  final EventModel eventModel;

  const EditEvent({Key? key, required this.petname, required this.eventModel})
      : super(key: key);
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final titelcontroller = TextEditingController();
  final descontroller = TextEditingController();

  String currentdate = Date.getStringdate();
  String eventdate = "Choose Date";
  String eventtime = "Choose Time";
  String titel = "";
  String description = "";
  String _setTime = "";
  String _hour = "", _minute = "", _time = "";
  int status = 0;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  bool donestatus = true;

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        keyboardhide(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade500,
          title: Text("Edit event"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.04),
              child: GestureDetector(
                  onTap: donestatus
                      ? () async {
                          String url = "mailto:supunnilakshana@gmail.com";
                          if (!await launch(url)) throw 'Could not launch $url';
                        } 
                      : null,
                  child: Icon(Icons.share)),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.04),
              child: GestureDetector(
                  onTap: donestatus
                      ? () async {
                          PopupDialog.showPopupDilog(
                              context, "Hello", "Did you done this event ?",
                              () async {
                            EventModel event = widget.eventModel;
                            event.status = 1;
                            int res = await FireDBHandeler.updateEvent(event);
                            if (res == 0) {
                              loaddata();
                              Fluttertoast.showToast(
                                  msg: "Done",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              donestatus = false;
                              setState(() {});
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Updating is failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        }
                      : null,
                  child: Icon(Icons.done_outline_rounded)),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.04),
              child: GestureDetector(
                  onTap: () async {
                    PopupDialog.showPopupWarning(
                        context, "Delete", "Are you sure to delete this event?",
                        () async {
                      int res = await FireDBHandeler.deletedoc(
                          widget.eventModel.id,
                          FireDBHandeler.MainUserpath + "event");
                      if (res == 0) {
                        Navigator.pop(context, true);
                        Fluttertoast.showToast(
                            msg: "Done",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        donestatus = false;
                        setState(() {});
                      } else {
                        Fluttertoast.showToast(
                            msg: "Updating is failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Icon(Icons.delete)),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                            enabled: donestatus,
                            controller: titelcontroller,
                            decoration: InputDecoration(
                              labelText: 'Titel',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              titel = value;
                            },
                            onSaved: (value) {},
                            validator: (text) {
                              return Validater.genaralvalid(text!);
                            }),
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: kprimaryColor,
                            ),
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            label: Text(
                              eventdate,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: donestatus
                                ? () {
                                    keyboardhide(context);
                                    _selectDate(context);
                                  }
                                : null,
                          )),
                    ),
                    Container(
                      width: size.width * 0.9,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: kprimaryColor,
                            ),
                            icon: Icon(
                              Icons.timer_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              eventtime,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: donestatus
                                ? () {
                                    keyboardhide(context);
                                    _selectTime(context);
                                  }
                                : null,
                          )),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                            enabled: donestatus,
                            controller: descontroller,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              description = value;
                            },
                            validator: (text) {
                              return Validater.genaralvalid(text!);
                            },
                            onSaved: (value) {},
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 8,
                            maxLines: null),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.09,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: kmenucolor,
                            ),
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: donestatus
                                ? () async {
                                    print(Date.datetimeBetween());
                                    if (_formKey.currentState!.validate()) {
                                      if (eventdate != "Choose Date" ||
                                          eventtime != "Choose Time") {
                                        print("ok");

                                        EventModel event = EventModel(
                                            Date.getDateTimeId(),
                                            titelcontroller.text,
                                            description,
                                            eventdate,
                                            eventtime,
                                            DateTime.now().toString(),
                                            widget.eventModel.status);
                                        int res =
                                            await FireDBHandeler.updateEvent(
                                                event);
                                        if (res == 0) {
                                          Navigator.pop(context, true);
                                          Fluttertoast.showToast(
                                              msg: "Event is updated",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Event updating is failed",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      } else {
                                        PopupDialog.showPopupErorr(
                                            context,
                                            "Error",
                                            "Please choose event date and time..");
                                      }
                                    }
                                  }
                                : null,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        eventdate =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        setState(() {});
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;

        ///  Date.timeBetween(_time,Date.daysBetween(from));

        eventtime = formatDate(
            DateTime(1999, 11, 30, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();

        print(_time);
        setState(() {});
      });
  }

  loaddata() {
    titelcontroller.text = widget.eventModel.title;
    descontroller.text = widget.eventModel.description;
    eventdate = widget.eventModel.eventDate;
    eventtime = widget.eventModel.eventtime;
    status = widget.eventModel.status;
    if (widget.eventModel.status == 0) {
      donestatus = true;
    } else {
      donestatus = false;
    }
    setState(() {});
  }

  keyboardhide(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
