import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/tots.dart';
import 'package:pet1/screens/fogetpassword/fogetPwScreen.dart';
import 'package:pet1/screens/login/loginscreen.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDrawer extends StatelessWidget {
  final String name;
  MenuDrawer({
    Key? key,
    required this.gauth,
    required this.name,
  }) : super(key: key);
  final GoogleSignInProvider gauth;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.deepPurpleAccent.withOpacity(1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/dashappbar.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                  color: Colors.deepPurple),
              accountEmail: Text(user!.email.toString()),
              accountName: Text(name),
              currentAccountPicture: user.providerData[0].providerId ==
                      'google.com'
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL.toString()),
                    )
                  : Image.asset("assets/icons/user.png"),
            ),
            user.providerData[0].providerId == 'google.com'
                ? Container()
                : Card(
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Reset Password'),
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
                    ),
                  ),
            Card(
              child: ListTile(
                leading: Icon(Icons.web),
                title: const Text('Visit our Website'),
                onTap: () async {
                  const url = "http://petzreview.com/";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    Customtost.commontost("Can't open web", Colors.redAccent);
                  }
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: const Text('About Us'),
                onTap: () {
                  Customtost.commontost(
                      "We are Zeedx Developers", Colors.amber);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Petzy Version'),
                onTap: () {
                  Customtost.commontost("Version 1.0.0", Colors.amber);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout_rounded),
                title: const Text('Logout'),
                onTap: () {
                  PopupDialog.showPopuplogout(
                      context, "Signout", "Do you want to signout ? ",
                      () async {
                    if (user.providerData[0].providerId == 'google.com') {
                      print("isgauth");
                      await gauth.logout();
                    } else {
                      await FirebaseAuth.instance.signOut();
                    }

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    print("logingout");
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CustRoundedButton(
            //     height: size.height * 0.06,
            //     width: size.width * 0.25,
            //     text: "Logout",
            //     onpress: () async {
            //       // print(user.providerData[0].providerId);

            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
