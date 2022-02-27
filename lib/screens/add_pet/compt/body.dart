import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/firedbhandeler/user_handeler.dart';
import 'package:pet1/controllers/models/pet_list.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';

import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/dropdown_list.dart';
import 'package:pet1/screens/components/rounded_selectedbutton.dart';

import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';
import 'package:pet1/screens/components/tots.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:pet1/services/file_upload.dart';

import 'backgound.dart';

class Body extends StatefulWidget {
  final int pettype;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Body({
    Key? key,
    required this.pettype,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PetdbHandeler pd = PetdbHandeler();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isupload = true;
  String date = "";
  DateTime selectedDate = DateTime.now();
  late String name;
  late String type;
  int spec = 0;
  String dob = "";
  late String color;
  int gender = 0;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool isimgload = false;
  late Uint8List imgunitfile;
  final user = FirebaseAuth.instance.currentUser;
  String imgurl = "";

  @override
  Widget build(BuildContext context) {
    String proimg;
    Size size = MediaQuery.of(context).size;

    final List<ListItem> listitem;
    if (widget.pettype == 0) {
      proimg = "assets/images/previewdog1.jpg";
      listitem = doglist;
      type = 'dog';
    } else {
      proimg = "assets/images/previewcat1.jpg";
      listitem = catlist;
      type = 'cat';
    }

    return Background(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Tell us about your  pet ",
                style: TextStyle(
                    fontSize: size.width * 0.08, color: kheadingcolorlight),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.width * 0.4,
                width: size.height * 0.17,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: size.width * 0.17,
                            backgroundImage: FileImage(File(_image!.path)),
                          )
                        : CircleAvatar(
                            radius: size.width * 0.17,
                            backgroundImage: AssetImage(proimg),
                          ),
                    Positioned(
                        bottom: 0,
                        right: -25,
                        child: RawMaterialButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _showPicker(context);
                          },
                          elevation: 2.0,
                          fillColor: Color(0xFFF5F6F9),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              RoundedInput(
                hintText: "Pet Name",
                onchange: (text) {
                  name = text;
                },
                valid: (text) {
                  return Validater.genaralvalid(text!);
                },
                save: (value) {},
                icon: Icons.pets,
                // onChange: (value) {},
              ),
              RoundedSelectButton(
                icon: Icons.date_range,
                onpress: (context) {
                  FocusScope.of(context).unfocus();
                  _selectDate(context);
                },
                text: "Choose your pet's birthday",
              ),
              /*ElevatedButton(
                child: Text("press"),
                onPressed: () => _selectDate(context),
              ),*/
              dob != ""
                  ? Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                  : SizedBox(
                      height: 0,
                    ),
              DropdownList(
                hinttext: Text("Select pet's species"),
                onchange: (value) {
                  setState(() {
                    spec = value as int;
                  });
                  FocusScope.of(context).unfocus();

                  print(value);
                },
                typelist: listitem,
              ),
              DropdownList(
                hinttext: Text("Select pet's gender"),
                onchange: (value) {
                  gender = value as int;

                  print(value);
                  FocusScope.of(context).unfocus();
                },
                typelist: genderlist,
              ),
              RoundedInput(
                  hintText: "Your pet's Color",
                  onchange: (text) {
                    color = text;
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (value) {},
                  icon: Icons.color_lens_sharp),
              RoundedButton(
                text: "Continue",
                onpress: isupload
                    ? () async {
                        // print(gender);
                        print(isimgload);
                        if (_formKey.currentState!.validate() &&
                            ((dob != "") && (spec != 0) && (gender != 0))) {
                          setState(() {
                            isupload = false;
                          });
                          // ignore: deprecated_member_use
                          widget.scaffoldKey.currentState!
                              .showSnackBar(new SnackBar(
                            duration: new Duration(seconds: 2),
                            backgroundColor: Colors.purpleAccent.shade700,
                            content: new Row(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                                new Text(" Registering...")
                              ],
                            ),
                          ));
                          String id = "petproimg";
                          String imgsetpath =
                              "users/" + user!.email! + "/" + name;
                          print("pressed");
                          if (isimgload) {
                            print("imgeuploading");
                            imgurl = await ImageUploader.uploadData(
                                imgunitfile, imgsetpath, id);

                            print("imgeuploaded");
                          }
                          Pet pet = Pet(
                              id: id,
                              name: name,
                              type: type,
                              spec: spec,
                              dob: dob,
                              color: color,
                              gender: gender,
                              imgurl: imgurl);
                          int respons = await FireDBHandeler.addPet(pet);

                          if (respons == 1) {
                            await FireDBHandeler.initDayactivity(name);
                            await FireDBHandeler.initweightDoc(name);
                            Customtost.commontost(
                                "Added Sucessfully", Colors.amber);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dasboard(
                                          petname: pet.name,
                                        )));
                          } else {
                            setState(() {
                              isupload = true;
                            });
                            Customtost.commontost(
                                "Somthing went wrong", Colors.red);
                          }
                          // print("added");
                          // List<String> petlist = await UserdbHandeler.getPetlist();
                          // String petname = petlist.first;
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Dasboard(
                          //               petname: petname,
                          //             )));
                        } else {
                          print("Not Complete");
                          Customtost.commontost(
                              "Complete the form", Colors.redAccent);
                        }
                      }
                    : () {
                        Customtost.commontost(
                            "Uploading is progress", Colors.lightBlue);
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
        dob = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;

        File imageFile = new File(_image!.path);
        imgunitfile = imageFile.readAsBytesSync();
        isimgload = true;
        // widget.onimgfileChanged(base64Image);
      });
    }
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;
        File imageFile = new File(_image!.path);
        imgunitfile = imageFile.readAsBytesSync();
        isimgload = true;
        // widget.onimgfileChanged(base64Image);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
