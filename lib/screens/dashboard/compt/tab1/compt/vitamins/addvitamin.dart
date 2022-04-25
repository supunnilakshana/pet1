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

class AddVitamin extends StatefulWidget {
  final String petname;

  const AddVitamin({Key? key, required this.petname}) : super(key: key);
  @override
  _AddVitaminState createState() => _AddVitaminState();
}

class _AddVitaminState extends State<AddVitamin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final titelcontroller = TextEditingController();
  final descontroller = TextEditingController();

  String currentdate = Date.getStringdate();
  String eventdate = "Choose  Date";
  String eventtime = "Choose Time";
  String titel = "";
  String description = "";
  String _setTime = "";
  String _hour = "", _minute = "", _time = "";
  int repeatcount = 0;
  bool isrepeat = true;
  String repeatType = "D";
  String repeateString = "Days";

  DateTime selectedDate = DateTime.now();
  var timenow = DateTime.now();
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
                      "Add a vitamin",
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
                              labelText: 'Vitamin name',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" Vitamin Repeat   ",
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                )),
                            Container(
                              child: Switch(
                                onChanged: (value) {
                                  isrepeat = value;
                                  setState(() {});
                                },
                                value: isrepeat,
                                activeColor: Colors.deepPurpleAccent,
                                activeTrackColor: Colors.deepPurple.shade200,
                                inactiveThumbColor: Colors.deepPurple.shade300,
                                inactiveTrackColor: Colors.deepPurple.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isrepeat
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: size.width * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text("Repeat  ",
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Container(
                                            width: size.width * 0.19,
                                            padding: EdgeInsets.all(
                                                size.width * 0.007),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.01),
                                                color: kprimaryColor),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      if (repeatcount > 0) {
                                                        setState(() {
                                                          repeatcount--;
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: size.width * 0.04,
                                                    )),
                                                Container(
                                                  width: size.width * 0.075,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.007),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.007,
                                                      vertical:
                                                          size.width * 0.005),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              size.width *
                                                                  0.007),
                                                      color: Colors.white),
                                                  child: Text(
                                                    repeatcount.toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            size.width * 0.04),
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      if (repeatcount < 40) {
                                                        setState(() {
                                                          repeatcount++;
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: size.width * 0.04,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.02),
                                      child: PopupMenuButton(
                                          color: Colors.deepPurpleAccent,
                                          child: Text(repeateString,
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          onSelected: (value) {
                                            if (value == 1) {
                                              repeatType = "D";
                                              repeateString = "Days";
                                            } else {
                                              repeatType = "H";
                                              repeateString = "Hours";
                                            }
                                            setState(() {});
                                          },
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: Text(
                                                    "Days",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  value: 1,
                                                ),
                                                PopupMenuItem(
                                                  child: Text("Hours",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  value: 2,
                                                )
                                              ]),
                                    )
                                  ],
                                )),
                          )
                        : SizedBox(
                            height: 0,
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
                              labelText: 'Note',
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
                            minLines: 4,
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
                              "Add",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              // print(Date.datetimeBetween());
                              if (_formKey.currentState!.validate()) {
                                if (eventdate != "Choose Date" ||
                                    eventtime != "Choose Time") {
                                  print("ok");

                                  int repat = 0;
                                  if (isrepeat) {
                                    repat = 1;
                                  } else {
                                    repat = 0;
                                  }
                                  Vitamin vitamin = Vitamin(
                                      id: Date.getDateTimeId(),
                                      name: titelcontroller.text,
                                      description: description,
                                      vitCreateDate: DateTime.now().toString(),
                                      vitNextDate: eventdate,
                                      repatestatus: repat,
                                      repatecount: repeatcount,
                                      repatetype: repeatType,
                                      vitNextTime: eventtime);
                                  int res = await FireDBHandeler.addVitamin(
                                      vitamin, widget.petname);
                                  if (res == 1) {
                                    Navigator.pop(context, true);
                                    Fluttertoast.showToast(
                                        msg: "Vitamin  is added",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Vitamin adding is failed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } else {
                                  PopupDialog.showPopupErorr(context, "Error",
                                      "Please choose vitamin date and time..");
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
