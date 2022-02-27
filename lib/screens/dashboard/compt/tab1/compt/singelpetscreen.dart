import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/singelpet_tabbar.dart';
import 'package:pet1/screens/dashboard/compt/weight_screen/weight_screen.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:pet1/screens/edit_pet/edit_pet_screen.dart';
import 'package:pet1/services/file_upload.dart';

class SingelPetScreen extends StatefulWidget {
  final Pet pet;

  const SingelPetScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _SingelPetScreenState createState() => _SingelPetScreenState();
}

class _SingelPetScreenState extends State<SingelPetScreen> {
  String weight = "Add";
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    loadweight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade700,
          elevation: 0,
          shadowColor: Colors.deepPurple.shade700,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: size.width * 0.02),
                child: IconButton(
                  focusColor: Colors.pink,
                  icon: Icon(
                    Icons.info_outline,
                    size: size.width * 0.08,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditPetScreen(pet: widget.pet)));
                  },
                )),
            Padding(
                padding: EdgeInsets.only(right: size.width * 0.02),
                child: IconButton(
                  focusColor: Colors.pink,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: size.width * 0.08,
                  ),
                  onPressed: () async {
                    PopupDialog.showPopupWarning(
                        context, "Delete", "Are you sure to delete this pet?",
                        () async {
                      int res = await FireDBHandeler.deletedoc(
                          widget.pet.name, FireDBHandeler.MainUserpath + "pet");
                      String deletecollectpath =
                          "users/" + user!.email! + "/" + widget.pet.name;
                      ImageUploader.deletefile(deletecollectpath, "petproimg");
                      if (res == 0) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Dasboard(petname: widget.pet.name)));
                        Fluttertoast.showToast(
                            msg: "Sucessfully Deleted",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
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
                )),
          ],
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade700,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(size.width * 0.08),
                          bottomLeft: Radius.circular(size.width * 0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade100,
                          blurRadius:
                              1.0, // has the effect of softening the shadow
                          spreadRadius:
                              2.0, // has the effect of extending the shadow
                          offset: Offset(
                            3.0, // horizontal, move right 10
                            3.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.005,
                            left: size.width * 0.1,
                            right: size.width * 0.1,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.05)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.shade100,
                                  blurRadius:
                                      1.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      1.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    3.0, // horizontal, move right 10
                                    3.0, // vertical, move down 10
                                  ),
                                ),
                                BoxShadow(
                                  color: Colors.deepPurple.shade100,
                                  blurRadius:
                                      1.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      1.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    -3, // horizontal, move right 10
                                    -3, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.05)),
                              child: widget.pet.imgurl != ""
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: size.height * 0.3,
                                      width: size.width * 0.8,
                                      imageUrl: widget.pet.imgurl,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Container(
                                        //  height: size.height * 0.01,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : Image.asset(
                                      "assets/images/previewdog1.jpg"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.011),
                          child: Text(
                            widget.pet.name,
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.011,
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                width: size.width * 0.2,
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 0.05)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.02),
                                      child: Image.asset(
                                        "assets/icons/vaccineiconnon.png",
                                        height: size.height * 0.05,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Vaccine",
                                          style: TextStyle(
                                              fontSize: size.width * 0.03,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "2/3",
                                          style: TextStyle(
                                              fontSize: size.width * 0.055,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        // RichText(
                                        //   text: TextSpan(
                                        //     text: "51",
                                        //     style: TextStyle(
                                        //         fontSize: size.width * 0.055,
                                        //         color: Colors.white,
                                        //         fontWeight: FontWeight.w900),
                                        //     children: <TextSpan>[
                                        //       TextSpan(
                                        //           text: 'KG',
                                        //           style: TextStyle(
                                        //               fontSize: size.width * 0.03,
                                        //               color: Colors.white,
                                        //               fontWeight: FontWeight.w400)),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WeightScreen(
                                              reloadbutton: () {
                                                loadweight();
                                              },
                                              petname: widget.pet.name))).then(
                                      loadweight());
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 0.05)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.02),
                                        child: Image.asset(
                                          "assets/icons/weighingmachinenon.png",
                                          height: size.height * 0.05,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Weight",
                                            style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            weight,
                                            style: TextStyle(
                                                fontSize: size.width * 0.055,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SingelPetTabBar(
                    petname: widget.pet.name,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  loadweight() async {
    List<Weight> weightlist = await FireDBHandeler.geteWeight(widget.pet.name);
    weight = weightlist.last.value.toString() + " Kg";
    setState(() {});
  }
}
