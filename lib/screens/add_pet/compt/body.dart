import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_list.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';

import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/dropdown_list.dart';

import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';

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
  @override
  Widget build(BuildContext context) {
    String proimg;
    Size size = MediaQuery.of(context).size;
    final List<ListItem> listitem;
    if (widget.pettype == 0) {
      proimg = "assets/images/dog.jpg";
      listitem = doglist;
      pet.type = 'dog';
    } else {
      proimg = "assets/images/cat.jpg";
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
              RoundedInput(
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
              ),
              DropdownList(
                onchange: (value) {
                  pet.spec = value as int;

                  print(value);
                },
                typelist: listitem,
              ),
              RoundedInput(
                  hintText: "Weight",
                  onchange: (text) {
                    pet.weight = double.parse(text);
                    print(pet.weight);
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (value) {},
                  textinput: TextInputType.number,
                  icon: Icons.pets
                  // onChange: (value) {},
                  ),
              RoundedButton(
                text: "Continue",
                onpress: () async {
                  if (_formKey.currentState!.validate()) {
                    print("pressed");
                    print(pet);
                    await pd.adduser();
                    await pd.addPet(pet);
                    print("added");
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
}
