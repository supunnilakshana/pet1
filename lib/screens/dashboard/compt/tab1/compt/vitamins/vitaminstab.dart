import 'package:flutter/material.dart';
import 'package:pet1/screens/components/buttons.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/vitamins/vitaminscreen.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/vitamins/vitaminweview.dart';

class VitaminTab extends StatelessWidget {
  final String petname;
  final String type;

  const VitaminTab({Key? key, required this.petname, required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(type);
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: Text("Check and set vitamins"),
      //   icon: Icon(Icons.medication_rounded),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        width: size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(size.width * 0.05)),
              image: DecorationImage(
                image: AssetImage(type == 'dog'
                    ? "assets/images/vitaminback.jpg"
                    : "assets/images/catbackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, bottom: size.height * 0.05),
                  child: Iconbutton(
                    bicon: Icon(Icons.medication_rounded),
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VitaminScreen(petname: petname)));
                    },
                    text: "Check and set vitamins",
                    color: Colors.deepPurpleAccent.shade400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, bottom: size.height * 0.05),
                  child: Iconbutton(
                    bicon: Icon(Icons.medication_rounded),
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VitaminWebView()));
                    },
                    text: "Suggets vitamins",
                    color: Colors.blueAccent.shade400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
