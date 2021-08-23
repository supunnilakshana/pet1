import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/authentication/email/email_auth.dart';
import 'package:pet1/screens/components/already_have_an_account_acheck.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/or_divider.dart';
import 'package:pet1/screens/components/roundPasswordFiled.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';
import 'package:pet1/screens/components/social_icon.dart';
import 'package:pet1/screens/dashboard/dashboard_screen.dart';
import 'package:pet1/screens/login/loginscreen.dart';

import 'backgound.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _email = "";
    String _password = "";
    String _name = "";
    var emailauth = EmailAuth();

    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.25,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            RoundedInput(
              onchange: (text) {
                _name = text;
                print(text);
              },
              hintText: "Your Name",
            ),
            RoundedInput(
              onchange: (text) {
                _email = text;
                print(text);
              },
              hintText: "Your Email",
              icon: Icons.mail,
            ),
            RoundedPasswordfiled(
              change: (text) {
                _password = text;
              },
            ),
            RoundedButton(
              text: "Sign Up",
              onpress: () {
                print("presssignup");
                print(_email);
                print(_password);
                print(_name);
                emailauth.handleSignUp(_email, _password).then((user) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Dasboard()));
                }).catchError((e) => (e));
              },
              color: kprimaryColor,
              textcolor: Colors.white,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-symbol.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/apple-logo.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
