import 'package:firebase_auth/firebase_auth.dart';

class Emtest {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future etest(String em, String pw) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: em, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
