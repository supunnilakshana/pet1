import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/components/roundedbutton.dart';

class Dasboard extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  var gauth = GoogleSignInProvider();
  var pethandeler = PetdbHandeler();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xFF0f131a),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hellow",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 50),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user!.photoURL.toString()),
            ),
            SizedBox(height: 20),
            Text(user!.email.toString(),
                style: TextStyle(fontSize: 24, color: Colors.white)),
            RoundedButton(
              text: "add",
              onpress: () async {
                await pethandeler.adduser();
                await pethandeler
                    .addPet(Pet("_id", "kukku", "_type", 0, 10, 5.2));
                print("---------------------------------ok");
              },
            ),
            RoundedButton(
              text: "Signout",
              onpress: () async {
                gauth.logout();
              },
            )
          ],
        ),
      ),
    );
  }
}
