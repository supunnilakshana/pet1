import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/firestore_status.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/firedbhandeler/user_handeler.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen_new.dart';

import 'compt/background.dart';

class LoadingcheckScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoadingcheckScreen> {
  String animi1 = "assets/animations/walkingdoganimi.json";
  String animi2 = "assets/animations/rundogaimi.json";
  String animi3 = "assets/animations/walkinwtihdoganimi.json";
  Color color1 = Color(0xFF8456C4);
  Color color2 = Color(0xFFa72ff7);
  Color color3 = Color(0xFFc1b3e8);
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    int scno = random.nextInt(3);
    print("-----------" + scno.toString());
    if (scno == 0) {
      return loadingnewScreen(context, animi1, color1);
    } else if (scno == 0) {
      return loadingnewScreen(context, animi2, color2);
    } else {
      return loadingnewScreen(context, animi3, color3);
    }
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() async {
    final user = FirebaseAuth.instance.currentUser;
    var status = await Firedoc.checkdoc("users", user!.email.toString());
    PetdbHandeler pd = PetdbHandeler();
    List<String> petlist;
    String petname;

    // ignore: unrelated_type_equality_checks
    if (status == 0) {
      print("all ready exists");
      var count = await UserdbHandeler.userPetcount();
      print('count is ' + count.toString());
      petlist = await UserdbHandeler.getPetlist();
      if (count == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectPetScreenNew()));
      } else {
        petlist = await UserdbHandeler.getPetlist();
        petname = petlist.first;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Dasboard(
                      petname: petname,
                    )));
      }

      // ignore: unrelated_type_equality_checks
    } else if (status == 1) {
      print("not exists");

      UserdbHandeler.adduser();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => SelectPetScreenNew()));
    } else {
      print("error");
      return Center(
        child: Text("Somthing wrong"),
      );
    }
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("loading");
    return Scaffold(
        body: Background(
      child: Positioned(
        bottom: 0,
        child: Lottie.asset('assets/animations/dogwalking.json',
            width: size.width * 0.9),
      ),
    ));
  }

  loadingnewScreen(BuildContext context, String animi, Color color) {
    Size size = MediaQuery.of(context).size;
    print("loading");
    return Scaffold(
        backgroundColor: color,
        body: Container(
          color: color,
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(animi, width: size.width),
            ],
          ),
        ));
  }
}
