import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // final googleUser = await googleSignIn.signIn();
            // print(googleUser);
            // if (googleUser == null) return;
            // _user = googleUser;
            // final googleAuth = await googleUser.authentication;

            // print(googleAuth.idToken);

            // Uri url =
            //     Uri.parse('https://192.168.0.134:45455/Home/ExternalLogin');
            // final respons = await http.post(
            //   url,
            //   headers: <String, String>{
            //     'Content-Type': 'application/json; charset=UTF-8',
            //   },
            //   body: jsonEncode(<String, dynamic>{
            //     'provider': 'GOOGLE',
            //     'idToken': googleAuth.idToken
            //   }),
            // );
            // print(respons.statusCode);
            // print(respons.body);
          },
          label: Text("Test")),
      body: Container(),
    );
  }
}
