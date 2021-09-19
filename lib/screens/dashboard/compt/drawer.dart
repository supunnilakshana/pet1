import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/screens/components/custermized_rounded_button.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/login/loginscreen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
    required this.gauth,
  }) : super(key: key);
  final GoogleSignInProvider gauth;
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
              image: DecorationImage(
                image: AssetImage("assets/images/dashappbar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            accountEmail: Text(user!.email.toString()),
            accountName: Text(user.displayName.toString()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL.toString()),
            ),
          ),
          ListTile(
            title: const Text(''),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(''),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: size.height * 0.3,
          ),
          CustRoundedButton(
            height: size.height * 0.07,
            width: size.width * 0.3,
            text: "Logout",
            onpress: () async {
              PopupDialog.showPopuplogout(
                  context, "Signout", "Do you want to signout ? ", () async {
                await gauth.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                print("logingout");
              });
            },
          )
        ],
      ),
    );
  }
}
