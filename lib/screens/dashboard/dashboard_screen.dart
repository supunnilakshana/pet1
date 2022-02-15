import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/dashboard/compt/account_tab/account_screen.dart';
import 'package:pet1/screens/dashboard/compt/tab2/event_tab.dart';
import 'package:pet1/screens/dashboard/compt/tab3/tab3.dart';
import 'compt/Tab1/tab_1_screen.dart';
import 'compt/drawer.dart';

class Dasboard extends StatefulWidget {
  final String petname;
  final int index;

  const Dasboard({Key? key, required this.petname, this.index = 0})
      : super(key: key);
  @override
  _DasboardState createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  var pd = PetdbHandeler();
  var gauth = GoogleSignInProvider();
  CircelProgressHandeler c = CircelProgressHandeler();

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> _widgetOptions = <Widget>[
      AccountScreen(),
      Tab3(),
      EventTab(petname: widget.petname),
      // Tab1(gauth: gauth, pd: pd, petname: widget.petname),
      // Tab2(petname: widget.petname),
      Tab3()
    ];

    return Scaffold(
      key: _scaffoldKey,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_rounded),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Updates',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kprimaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.75),
        onTap: _onItemTapped,
      ),
    );
  }
}
