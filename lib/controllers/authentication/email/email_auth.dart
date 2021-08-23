import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User> handleSignUp(email, password) async {
    print("ok1");
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("ok1");
    final User user = result.user!;
    print("ok1");

    return user;
  }
}
