import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/welcomebackground.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.12,
          ),
          Text(
            "\"Pets Understand humans\n better than humans do\"",
            style: GoogleFonts.lobster(
              fontSize: size.width * 0.07,
            ),
          )
        ],
      ),
    ));
  }
}
