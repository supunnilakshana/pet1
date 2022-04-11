import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';
import 'package:pet1/screens/components/tots.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WeightInput {
  static popupWeight(
    BuildContext context,
    String petname,
    Function() onpressok,
  ) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    double weightValue = 0.0;
    Alert(
        context: context,
        title: "Enter your pet weight",
        content: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
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
        ),
        buttons: [
          DialogButton(
            color: Colors.deepPurpleAccent.shade700,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                print("pressed");
                Weight w = Weight(
                    Date.getDateTimeId(), Date.getStringdate(), weightValue);

                int res = await FireDBHandeler.updateWeight(petname, w);
                if (res == 1) {
                  Customtost.commontost("Updated succesfully", Colors.green);
                  print("added weight");
                  Navigator.pop(context);
                  onpressok();
                  // reload();
                } else {
                  Customtost.commontost("Update failed", Colors.red);
                }
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
