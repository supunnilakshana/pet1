import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet1/screens/components/constansts.dart';

import 'backgound.dart';

class InputEvent extends StatefulWidget {
  @override
  _InputEventState createState() => _InputEventState();
}

class _InputEventState extends State<InputEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final titelcontroller = TextEditingController();
  final descontroller = TextEditingController();

  String date = "";
  String eventdate = "";
  String eventtime = "";
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
        appBar: AppBar(
          title: Text("Create event"),
        ),
        body: SingleChildScrollView(
          child: Background(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          controller: titelcontroller,
                          decoration: InputDecoration(
                            labelText: 'Titel',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
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
                              "Choose Date",
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
                            ),
                            icon: Icon(
                              Icons.timer_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Choose Time",
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
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                            controller: descontroller,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {},
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
                              "Create",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
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
        _time = _hour + ' : ' + _minute;
        eventtime = formatDate(DateTime(selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        print(eventtime);
      });
  }

  keyboardhide(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
