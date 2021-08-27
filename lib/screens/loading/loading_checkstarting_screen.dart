import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/firestore_status.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen.dart';

class LoadingcheckScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoadingcheckScreen> {
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

  route() async {
    final user = FirebaseAuth.instance.currentUser;
    var status = await Firedoc.checkdoc("users", user!.email.toString());
    PetdbHandeler pd = PetdbHandeler();

    // ignore: unrelated_type_equality_checks
    if (status == 0) {
      print("all ready exists");
      var count = await pd.userPetcount();
      print('count is ' + count.toString());
      if (count == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectPetscreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dasboard()));
      }

      // ignore: unrelated_type_equality_checks
    } else if (status == 1) {
      print("not exists");

      pd.adduser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SelectPetscreen()));
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
        body: Container(
      child: Center(child: Lottie.asset('assets/animations/dogwalking.json')),
    ));
  }
}
