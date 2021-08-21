import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/roundPasswordFiled.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/components/roundedtextFiled.dart';
import 'package:pet1/screens/login/compt/backgound.dart';

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
              height: size.height * 0.03,
            ),
            Text(
              "Login",
              style: TextStyle(fontSize: 20.2, fontWeight: FontWeight.bold),
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
              onpress: () {},
              color: kprimaryColor,
              textcolor: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Dont have an account?"),
                Text(
                  "SignUp",
                  style: TextStyle(
                      color: kprimaryColor, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
