import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuth extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<int> emailsignUp(String em, String pw) async {
    int r = 0;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: em, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        r = 1;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        r = 2;
      }
    } catch (e) {
      r = 3;
      print(e);
    }

    notifyListeners();

    return r;
  }

  Future emailsignIN(em, pw) async {
    int r = 0;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: em, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        r = 1;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        r = 2;
        print('Wrong password provided for that user.');
      }
    }
    return r;
  }
}
