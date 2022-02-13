import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/screens/loading/loading_checkstarting_screen.dart';
import 'package:pet1/screens/login/compt/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return LoadingcheckScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Somthing wrong!!"),
          );
        } else {
          return Body();
        }
      },
    ));
  }
}
