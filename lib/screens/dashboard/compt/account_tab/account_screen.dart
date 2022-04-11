import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/screens/dashboard/compt/drawer.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var gauth = GoogleSignInProvider();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.15),
        child: AppBar(
          elevation: 0,
          leading: Container(
              margin: EdgeInsets.only(left: 5),
              child: IconButton(
                icon: Icon(Icons.menu_open_sharp),
                iconSize: size.width * 0.1,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              )),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                radius: size.width * 0.08,
                backgroundImage: AssetImage(
                    "assets/images/dog.png"), // NetworkImage(user!.photoURL.toString()),
              ),
            ),
          ],
          flexibleSpace: Image.asset(
            "assets/images/dashappbar.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
      drawer: MenuDrawer(
        gauth: gauth,
      ),
      body: Center(
        child: Text("screen stil developing"),
      ),
    );
  }
}
