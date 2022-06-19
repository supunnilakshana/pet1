import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/tots.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VaccineInput {
  static popupWeight(
    BuildContext context,
    String petname,
    Vaccine vaccine,
    Function() onpressok,
  ) {
    Alert(
        context: context,
        title: "Enter your pet vaccination",
        content: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              VaccineInputItem(
                petname: petname,
                vaccine: vaccine,
                onpressok: onpressok,
              )
            ],
          ),
        ),
        buttons: []).show();
  }
}

class VaccineInputItem extends StatefulWidget {
  final Vaccine vaccine;
  final String petname;
  Function() onpressok;

  VaccineInputItem(
      {Key? key,
      required this.vaccine,
      required this.petname,
      required this.onpressok})
      : super(key: key);
  @override
  _VaccineInputItemState createState() => _VaccineInputItemState();
}

class _VaccineInputItemState extends State<VaccineInputItem> {
  int doseValue = 0;

  String vaccinedate = "Vaccinated Date";

  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.monitor_weight_rounded),
                    labelText: 'Dose no',
                  ),
                  onChanged: (value) {
                    doseValue = int.parse(value);
                    print(doseValue);
                  },
                  validator: (text) {
                    return Validater.isNumeric(text!);
                  },
                ),
                Container(
                  width: size.width * 0.6,
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
                          vaccinedate,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          keyboardhide(context);
                          _selectDate(context);
                        },
                      )),
                ),
                Container(
                  width: size.width * 0.5,
                  // height: size.height * 0.09,
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
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Create",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          // print(Date.datetimeBetween());
                          if (_formKey.currentState!.validate()) {
                            if (vaccinedate != "Vaccinated Date") {
                              print("ok");
                              final vsubitem = VaccineSub(
                                  Date.getDateTimeId(), vaccinedate, doseValue);
                              var templist = widget.vaccine.vaccinelist;
                              templist.add(vsubitem);
                              String next = "";
                              if (doseValue == 1) {
                                var nextdate = DateTime(selectedDate.year,
                                    selectedDate.month, selectedDate.day + 14);
                                next =
                                    "${nextdate.day}/${nextdate.month}/${nextdate.year}";
                              } else {
                                var nextdate = DateTime(selectedDate.year + 1,
                                    selectedDate.month, selectedDate.day);
                                next =
                                    "${nextdate.day}/${nextdate.month}/${nextdate.year}";
                              }

                              int res = await FireDBHandeler.updateVaccinelist(
                                  widget.petname,
                                  templist,
                                  widget.vaccine.id,
                                  next,
                                  (doseValue + 1).toString());
                              if (res == 1) {
                                Customtost.commontost("Added sucessfully",
                                    Colors.deepPurpleAccent);
                                FocusScope.of(context).unfocus();
                                widget.onpressok();
                              } else {
                                Customtost.commontost(
                                    "Somthing went wrong", Colors.redAccent);
                                FocusScope.of(context).unfocus();
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Select vaccinated date",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            Navigator.pop(context, true);
                          }
                        },
                      )),
                )
              ],
            ),
          ),
        ],
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
        vaccinedate =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
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
