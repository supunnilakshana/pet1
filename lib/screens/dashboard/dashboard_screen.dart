import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/dashboard/compt/tab2/tab2.dart';
import 'package:pet1/screens/dashboard/compt/tab3/tab3.dart';
import 'compt/Tab1/tab_1_screen.dart';
import 'compt/drawer.dart';

class Dasboard extends StatefulWidget {
  final String petname;

  const Dasboard({Key? key, required this.petname}) : super(key: key);
  @override
  _DasboardState createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  var pd = PetdbHandeler();
  var gauth = GoogleSignInProvider();
  CircelProgressHandeler c = CircelProgressHandeler();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> _widgetOptions = <Widget>[
      Tab1(gauth: gauth, pd: pd, petname: widget.petname),
      Tab2(),
      Tab3()
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.2),
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        onTap: _onItemTapped,
      ),
      drawer: MenuDrawer(
        gauth: gauth,
      ),
    );
  }
}
