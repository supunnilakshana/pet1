import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:pet1/screens/components/tots.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EditVitamin extends StatefulWidget {
  final String petname;
  final Vitamin vitaminModel;

  const EditVitamin(
      {Key? key, required this.petname, required this.vitaminModel})
      : super(key: key);
  @override
  _EditVitaminState createState() => _EditVitaminState();
}

class _EditVitaminState extends State<EditVitamin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  final titelcontroller = TextEditingController();
  final descontroller = TextEditingController();
  String currentdate = Date.getStringdate();
  String eventdate = "Choose Date";
  String eventtime = "Choose Time";
  String titel = "";
  String description = "";
  String _setTime = "";
  String _hour = "", _minute = "", _time = "";
  int repeatcount = 0;
  bool isrepeat = true;
  String repeatType = "D";
  String repeateString = "Day";

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
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
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
                  child: Image.asset(
                    "assets/icons/shareicon.png",
                    width: size.width * 0.08,
                  )),
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: size.width * 0.04),
            //   child: GestureDetector(
            //       onTap: donestatus
            //           ? () async {
            //               PopupDialog.showPopupDilog(
            //                   context, "Hello", "Did you done this event ?",
            //                   () async {
            //                 setState(() {
            //                   donestatus = false;
            //                 });
            //                 vitaminModel event = widget.vitaminModel;
            //                 event.status = 1;
            //                 int res = await FireDBHandeler.updateEvent(event);
            //                 if (res == 0) {
            //                   loaddata();
            //                   Fluttertoast.showToast(
            //                       msg: "Done",
            //                       toastLength: Toast.LENGTH_SHORT,
            //                       gravity: ToastGravity.BOTTOM,
            //                       backgroundColor: Colors.green,
            //                       textColor: Colors.white,
            //                       fontSize: 16.0);
            //                 } else {
            //                   setState(() {
            //                     donestatus = true;
            //                   });
            //                   Fluttertoast.showToast(
            //                       msg: "Updating is failed",
            //                       toastLength: Toast.LENGTH_SHORT,
            //                       gravity: ToastGravity.BOTTOM,
            //                       backgroundColor: Colors.red,
            //                       textColor: Colors.white,
            //                       fontSize: 16.0);
            //                 }
            //               });
            //             }
            //           : null,
            //       child: Image.asset(
            //         "assets/icons/checkicon.png",
            //         width: size.width * 0.08,
            //       )),
            // ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.04),
              child: GestureDetector(
                  onTap: () async {
                    String userpath = user!.email.toString();
                    PopupDialog.showPopupWarning(
                        context, "Delete", "Are you sure to delete this event?",
                        () async {
                      setState(() {
                        donestatus = false;
                      });
                      int res = await FireDBHandeler.deletedoc(
                          widget.vitaminModel.id,
                          FireDBHandeler.MainUserpath +
                              "/users/" +
                              userpath +
                              "/pet/" +
                              widget.petname +
                              "/vitamins");
                      if (res == 0) {
                        Navigator.pop(context, true);
                        Fluttertoast.showToast(
                            msg: "Done",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        setState(() {
                          donestatus = true;
                        });
                        Fluttertoast.showToast(
                            msg: "Deleting is failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Image.asset(
                    "assets/icons/trashicon.png",
                    width: size.width * 0.08,
                  )),
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
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Edit your pet's Vitamin",
                      style: TextStyle(
                          fontSize: size.width * 0.08,
                          color: kheadingcolorlight),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.04,
                            bottom: size.width * 0.04,
                            right: size.height * 0.04),
                        child: TextFormField(
                            enabled: donestatus,
                            controller: titelcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(width: 1, color: kprimaryColor),
                              ),
                              labelText: 'Vitamin Name',
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 2,
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 2,
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
                                                      if (repeatcount < 1000) {
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
                            left: size.width * 0.04,
                            top: size.height * 0.02,
                            right: size.width * 0.04),
                        child: TextFormField(
                            enabled: donestatus,
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
                            minLines: 3,
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
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 2,
                            ),
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: donestatus
                                ? () async {
                                    // print(Date.datetimeBetween());
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        donestatus = false;
                                      });
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
                                            id: widget.vitaminModel.id,
                                            name: titelcontroller.text,
                                            description: description,
                                            vitCreateDate:
                                                DateTime.now().toString(),
                                            vitNextDate: eventdate,
                                            repatestatus: repat,
                                            repatecount: repeatcount,
                                            repatetype: repeatType,
                                            vitNextTime: eventtime);
                                        int res =
                                            await FireDBHandeler.updateVitamin(
                                                vitamin, widget.petname);
                                        if (res == 0) {
                                          Navigator.pop(context, true);
                                          Fluttertoast.showToast(
                                              msg: "Vitamin is updated",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          setState(() {
                                            donestatus = true;
                                          });
                                        } else {
                                          setState(() {
                                            donestatus = true;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Vitamin updating is failed",
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
                                            "Please choose vitmain date and time..");
                                      }
                                    }
                                  }
                                : () {
                                    Customtost.commontost(
                                        "Uploading is progress",
                                        Colors.lightBlue);
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

  loaddata() {
    titelcontroller.text = widget.vitaminModel.name;
    descontroller.text = widget.vitaminModel.description;
    eventdate = widget.vitaminModel.vitNextDate;
    eventtime = widget.vitaminModel.vitNextTime;
    if (widget.vitaminModel.repatestatus == 1) {
      isrepeat = true;
    } else {
      isrepeat = false;
    }
    repeatcount = widget.vitaminModel.repatecount;
    repeatType = widget.vitaminModel.repatetype;

    // status = widget.vitaminModel.status;
    if (widget.vitaminModel.repatestatus == 1) {
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
