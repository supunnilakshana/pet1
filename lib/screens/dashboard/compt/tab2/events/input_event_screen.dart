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

import 'backgound.dart';

class InputEvent extends StatefulWidget {
  final String petname;

  const InputEvent({Key? key, required this.petname}) : super(key: key);
  @override
  _InputEventState createState() => _InputEventState();
}

class _InputEventState extends State<InputEvent> {
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

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

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
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
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
                    Text(
                      "Create an event",
                      style: TextStyle(
                          fontSize: size.width * 0.08,
                          color: kheadingcolorlight),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.04,
                            bottom: size.width * 0.04,
                            right: size.height * 0.04),
                        child: TextFormField(
                            controller: titelcontroller,
                            decoration: InputDecoration(
                              labelText: 'Titel',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(width: 1, color: kprimaryColor),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 2),
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            label: Text(
                              eventdate,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              keyboardhide(context);
                              _selectDate(context);
                            },
                          )),
                    ),
                    Container(
                      width: size.width * 0.9,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: kprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 2,
                            ),
                            icon: Icon(
                              Icons.timer_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              eventtime,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              keyboardhide(context);
                              _selectTime(context);
                            },
                          )),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            top: size.height * 0.02),
                        child: TextFormField(
                            controller: descontroller,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(width: 1, color: kprimaryColor),
                              ),
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
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
                      height: size.height * 0.05,
                    ),
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.09,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: kmenucolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              "Create",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              // print(Date.datetimeBetween());
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
                                      0);
                                  int res =
                                      await FireDBHandeler.addEvent(event);
                                  if (res == 1) {
                                    Navigator.pop(context, true);
                                    Fluttertoast.showToast(
                                        msg: "Event is created",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Event creating is failed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } else {
                                  PopupDialog.showPopupErorr(context, "Error",
                                      "Please choose event date and time..");
                                }
                              }
                            },
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

  keyboardhide(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
