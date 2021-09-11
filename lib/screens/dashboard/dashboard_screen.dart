import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/validators/date.dart';

import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/popup_dilog.dart';
import 'package:pet1/screens/components/roundedbutton.dart';

import 'package:pet1/screens/login/loginscreen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'compt/backgound.dart';
import 'compt/circleprogress_area.dart';

class Dasboard extends StatefulWidget {
  @override
  _DasboardState createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  final user = FirebaseAuth.instance.currentUser;
  var pd = PetdbHandeler();
  var gauth = GoogleSignInProvider();
  CircelProgressHandeler c = CircelProgressHandeler();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.2),
          child: AppBar(
            leading: Container(
              margin: EdgeInsets.only(left: 5),
              child: CircleAvatar(
                radius: size.width * 0.08,
                backgroundImage: AssetImage("assets/images/dog.png"),
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: CircleAvatar(
                  radius: size.width * 0.06,
                  backgroundImage: NetworkImage(user!.photoURL.toString()),
                ),
              ),
            ],
            flexibleSpace: Image.asset(
              "assets/images/appbackground.png",
              fit: BoxFit.cover,
            ),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.purpleAccent),
              tabs: <Widget>[
                Tab(
                  text: "Home",
                ),
                Tab(
                  text: "Events",
                ),
                Tab(
                  text: "Updates",
                ),
                Tab(
                  text: "Contacts",
                )
              ],
            ),
          ),
        ),
        body: TabBarView(children: <Widget>[
          Tab(
            child: Background(
              child: Container(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    ProgressArea(),
                    RoundedButton(
                      text: "Signout",
                      onpress: () async {
                        await gauth.logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                    RoundedButton(
                      text: "Get ",
                      onpress: () async {
                        /* PopupDialog.showPopupDilog(
                            context, "Bath", "Was your pet bathe Today ? ",
                            () async {
                          await pd.setBath("sukku");
                          print("adeed bath");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dasboard()));
                        });*/
                        c.bathtprogress();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Tab(
            icon: Icon(Icons.beach_access_sharp),
          ),
          Tab(
            icon: Icon(Icons.brightness_5_sharp),
          ),
          Tab(
            icon: Icon(Icons.brightness_5_sharp),
          ),
        ]),
      ),
    );
  }
}
