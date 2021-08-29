import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_list.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';

import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/dropdown_list.dart';
import 'package:pet1/screens/components/rounded_selectedbutton.dart';

import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';

import 'backgound.dart';

class Body extends StatefulWidget {
  final int pettype;

  const Body({
    Key? key,
    required this.pettype,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var pet = Pet();
  PetdbHandeler pd = PetdbHandeler();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String date = "";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String proimg;
    Size size = MediaQuery.of(context).size;

    final List<ListItem> listitem;
    if (widget.pettype == 0) {
      proimg = "assets/images/dog.png";
      listitem = doglist;
      pet.type = 'dog';
    } else {
      proimg = "assets/images/cat.png";
      listitem = catlist;
      pet.type = 'cat';
    }

    return SingleChildScrollView(
      child: Background(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Tell us about your  pet ",
                style: TextStyle(
                    fontSize: size.width * 0.08, color: kheadingcolorlight),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              CircleAvatar(
                radius: size.width * 0.17,
                backgroundImage: AssetImage(proimg),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              RoundedInput(
                hintText: "Pet Name",
                onchange: (text) {
                  pet.name = text;
                },
                valid: (text) {
                  return Validater.genaralvalid(text!);
                },
                save: (value) {},
                icon: Icons.pets,
                // onChange: (value) {},
              ),
              /*RoundedInput(
                hintText: "Age",
                onchange: (text) {
                  pet.age = int.parse(text);
                },
                valid: (text) {
                  return Validater.genaralvalid(text!);
                },
                save: (value) {},
                textinput: TextInputType.number,
                icon: Icons.pets,
              ),*/
              RoundedSelectButton(
                icon: Icons.date_range,
                onpress: (context) => _selectDate(context),
                text: "Choose your pet's birthday",
              ),
              /*ElevatedButton(
                child: Text("press"),
                onPressed: () => _selectDate(context),
              ),*/
              Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              DropdownList(
                hinttext: Text("Select pet's species"),
                onchange: (value) {
                  setState(() {
                    pet.spec = value as int;
                  });

                  print(value);
                },
                typelist: listitem,
              ),
              DropdownList(
                hinttext: Text("Select pet's gender"),
                onchange: (value) {
                  pet.gender = value as int;

                  print(value);
                },
                typelist: genderlist,
              ),
              /* RoundedInput(
                  hintText: "Weight",
                  onchange: (text) {
                    pet.weight = double.parse(text);
                    print(pet.weight);
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (value) {},
                  textinput: TextInputType.datetime,
                  icon: Icons.pets
                  // onChange: (value) {},
                  ),*/
              RoundedButton(
                text: "Continue",
                onpress: () async {
                  if (_formKey.currentState!.validate()) {
                    print("pressed");
                    print(pet);
                    await pd.adduser();
                    await pd.addPet(pet);
                    pd.updarePetcount();
                    print("added");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dasboard()));
                  } else {
                    print("Not Complete");
                  }
                },
                color: kprimaryColor,
                textcolor: Colors.white,
              ),
              SizedBox(height: size.height * 0.03),
            ],
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
        pet.dob =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }
}
