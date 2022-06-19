import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/login/loginscreen.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({
    Key? key,
    required this.gauth,
  }) : super(key: key);
  final GoogleSignInProvider gauth;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("assets/images/dashappbar.jpg"),
                //   fit: BoxFit.cover,
                // ),
                color: Colors.deepPurpleAccent),
            accountEmail: Text(user!.email.toString()),
            accountName: Text(user.displayName.toString()),
            currentAccountPicture: user.photoURL.toString() != ""
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL.toString()),
                  )
                : Image.asset("assets/icons/user.png"),
          ),
          ListTile(
            title: const Text(''),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Reset Password'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: size.height * 0.3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustRoundedButton(
              height: size.height * 0.06,
              width: size.width * 0.25,
              text: "Logout",
              onpress: () async {
                // print(user.providerData[0].providerId);
                PopupDialog.showPopuplogout(
                    context, "Signout", "Do you want to signout ? ", () async {
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
          )
        ],
      ),
    );
  }
}
