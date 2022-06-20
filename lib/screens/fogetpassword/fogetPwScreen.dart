import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
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
import 'package:pet1/screens/components/tots.dart';

import 'package:pet1/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'backgound.dart';

class FogetPWScreen extends StatefulWidget {
  const FogetPWScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FogetPWScreenState createState() => _FogetPWScreenState();
}

class _FogetPWScreenState extends State<FogetPWScreen> {
  String status = "";
  String _email = "";
  bool issent = true;
  bool ispress = false;
  var emailauth = EmailAuth();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: issent
              ? Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: WaveClipperOne(),
                        child: Container(
                          height: size.height * 0.12,
                          color: Colors.deepPurple,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.01,
                                bottom: size.width * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LineIcon.lock(
                                  size: size.width * 0.09,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Reset Passowrd",
                                  style: TextStyle(
                                      fontSize: size.width * 0.06,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Lottie.asset("assets/animations/emailsent.json",
                          width: size.width * 0.75),
                      Text(
                        "Check your email & reset your password",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.045,
                            color: kheadingcolorlight),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: size.width,
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipPath(
                          clipper: WaveClipperOne(),
                          child: Container(
                            height: size.height * 0.12,
                            color: Colors.deepPurple,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: size.width * 0.01,
                                  bottom: size.width * 0.1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LineIcon.lock(
                                    size: size.width * 0.09,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    "Reset Passowrd",
                                    style: TextStyle(
                                        fontSize: size.width * 0.06,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/icons/reset.png",
                          width: size.width * 0.5,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        RoundedInput(
                          icon: Icons.email,
                          hintText: "Your Email",
                          onchange: (text) {
                            _email = text.trim();
                            print(text);
                          },
                          valid: (text) {
                            return Validater.vaildemail(text!);
                          },
                          save: (value) {},

                          // onChange: (value) {},
                        ),
                        RoundedButton(
                          text: "Reset",
                          onpress: ispress
                              ? () {}
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    ispress = true;
                                    setState(() {});
                                    print("press login");
                                    print(_email);
                                    int r = await emailauth.resetPassword(
                                        email: _email);
                                    if (r == 1) {
                                      issent = true;
                                      Customtost.commontost(
                                          "Link sent successful",
                                          Colors.deepPurpleAccent);
                                    } else {}
                                  } else {
                                    Customtost.commontost(
                                        "Email verification failed",
                                        Colors.redAccent);
                                  }
                                  ispress = false;
                                  setState(() {});
                                },
                          color: kprimaryColor,
                          textcolor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
