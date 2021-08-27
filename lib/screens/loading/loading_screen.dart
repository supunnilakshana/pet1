import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pet1/screens/login/loginscreen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 10);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SelectPetscreen()));
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("loading");
    return Scaffold(
        body: Container(
      child: Center(child: Lottie.asset('assets/animations/dogwalking.json')),
    ));
  }
}
