import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/email/email_auth.dart';
import 'package:pet1/controllers/authentication/facebook/facebook_auth.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/validators/validate_handeler.dart';
import 'package:pet1/screens/components/already_have_an_account_acheck.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/or_divider.dart';
import 'package:pet1/screens/components/roundPasswordFiled.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';
import 'package:pet1/screens/components/social_icon.dart';
import 'package:pet1/screens/fogetpassword/fogetPwScreen.dart';
import 'package:pet1/screens/login/compt/backgound.dart';
import 'package:pet1/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import '../loginscreen.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String status = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _email = "";
    String _password = "";
    var emailauth = EmailAuth();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Background(
          child: Form(
            key: _formKey,
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
                  valid: (text) {
                    return Validater.vaildemail(text!);
                  },
                  save: (value) {},

                  // onChange: (value) {},
                ),
                RoundedPasswordfiled(
                  change: (text) {
                    _password = text;
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (text) {},
                ),
                Text(
                  status,
                  style: TextStyle(color: Colors.red),
                ),
                RoundedButton(
                  text: "Login",
                  onpress: () async {
                    if (_formKey.currentState!.validate()) {
                      print("press login");
                      print(_email);
                      print(_password);
                      await emailauth.emailsignIN(_email, _password);
                      int r = emailauth.getSigninstatus();
                      if (r == 0) {
                        print("loged");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      } else if (r == 1) {
                        setState(() {
                          status = "Please enter the correct email";
                        });
                      } else if (r == 2) {
                        setState(() {
                          status = "Please enter the correct password";
                        });
                      }
                    } else {
                      print("Not Complete");
                    }
                  },
                  color: kprimaryColor,
                  textcolor: Colors.white,
                ),
                SizedBox(height: size.height * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FogetPWScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
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
        ),
      ),
    );
  }
}
