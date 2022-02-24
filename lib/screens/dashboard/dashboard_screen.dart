import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/dashboard/compt/account_tab/account_screen.dart';
import 'package:pet1/screens/dashboard/compt/tab1/tab_1_screen.dart';
import 'package:pet1/screens/dashboard/compt/tab2/event_tab.dart';
import 'package:pet1/screens/dashboard/compt/tab3/tab3.dart';

class Dasboard extends StatefulWidget {
  final String petname;
  final int index;

  const Dasboard({Key? key, required this.petname, this.index = 1})
      : super(key: key);
  @override
  _DasboardState createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  var gauth = GoogleSignInProvider();
  CircelProgressHandeler c = CircelProgressHandeler();
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      AccountScreen(),
      HomeTab(petname: widget.petname),
      EventTab(petname: widget.petname),
      // Tab1(gauth: gauth, pd: pd, petname: widget.petname),
      // Tab2(petname: widget.petname),
      Tab3()
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: kprimaryColor,
              hoverColor: kmenucolor,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: kmenucolor.withOpacity(0.7),
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.user,
                  text: 'Account',
                ),
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.calendarAlt,
                  text: 'Events',
                ),
                GButton(
                  icon: LineIcons.globe,
                  text: 'Updates',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
