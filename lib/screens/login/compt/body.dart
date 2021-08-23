import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/email/emailauthtest.dart';
import 'package:pet1/controllers/authentication/facebook/facebook_auth.dart';
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
    String _email = "";
    String _password = "";
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.3,
            ),
            RoundedInput(
              hintText: "Your Email",
              onchange: (text) {
                _email = text;
                print(text);
              },
              // onChange: (value) {},
            ),
            RoundedPasswordfiled(
              change: (text) {
                _password = text;
              },
            ),
            RoundedButton(
              text: "Login",
              onpress: () {
                print("press login");
                print(_email);
                print(_password);
                var em = Emtest();
                em.etest();
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
                  press: () {
                    final provider =
                        Provider.of<FacebookLogin>(context, listen: false);
                    provider.signInWithFacebook();
                  },
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
