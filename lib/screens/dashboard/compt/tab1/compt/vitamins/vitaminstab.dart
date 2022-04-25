import 'package:flutter/material.dart';
import 'package:pet1/screens/components/buttons.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/vitamins/vitaminscreen.dart';

class VitaminTab extends StatelessWidget {
  final String petname;

  const VitaminTab({Key? key, required this.petname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: Text("Check and set vitamins"),
      //   icon: Icon(Icons.medication_rounded),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        width: size.width,
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
            )
          ],
        ),
      ),
    );
  }
}