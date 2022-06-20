import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuth extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int r = 0; //signup
  int i = 0; //sign in

  Future emailsignUp(String em, String pw) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: em, password: pw);
      r = 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        r = 1;
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        r = 2;
        print('The account already exists for that email.');
      }
    } catch (e) {
      r = 3;
      print(e);
    }

    notifyListeners();
  }

  Future emailsignIN(em, pw) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: em, password: pw);
      i = 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        i = 1;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        i = 2;
        print('Wrong password provided for that user.');
      }
    }
    notifyListeners();
  }

  Future<int> resetPassword({required String email}) async {
    int r = 0;
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => r = 1)
        .catchError((e) => r = 0);
    return r;
  }

  int getSignupstatus() {
    return r;
  }

  int getSigninstatus() {
    return i;
  }
}
