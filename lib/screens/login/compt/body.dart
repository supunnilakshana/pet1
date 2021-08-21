import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/screens/components/already_have_an_account_acheck.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/or_divider.dart';
import 'package:pet1/screens/components/roundPasswordFiled.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';
import 'package:pet1/screens/components/social_icon.dart';
import 'package:pet1/screens/login/compt/backgound.dart';
import 'package:pet1/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 28.2, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            RoundedInput(
              hintText: "Your Email",
              // onChange: (value) {},
            ),
            RoundedPasswordfiled(
                //onChange: (value) {},
                ),
            RoundedButton(
              text: "Login",
              onpress: () {
                print("tukku");
              },
              color: kprimaryColor,
              textcolor: Colors.white,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupScreen();
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
                  press: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
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
