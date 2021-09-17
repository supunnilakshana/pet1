import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WeightInput {
  static popupWeight(BuildContext context, String petname) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    double weightValue = 0.0;
    Alert(
        context: context,
        title: "Enter your pet weight",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.monitor_weight_rounded),
                  labelText: 'weight',
                ),
                onChanged: (value) {
                  weightValue = double.parse(value);
                  print(weightValue);
                },
                validator: (text) {
                  return Validater.isNumeric(text!);
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                print("pressed");
                Weight w = Weight(Date.getStringdate(), weightValue);
                var pd = PetdbHandeler();
                await pd.setWeight(petname, w);
                print("added weight");
                Navigator.pop(context);
              }
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
