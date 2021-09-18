import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/datahandeler/circle_progress_handeler.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'compt/Tab1/tab_1_screen.dart';

class Dasboard extends StatefulWidget {
  final String petname;

  const Dasboard({Key? key, required this.petname}) : super(key: key);
  @override
  _DasboardState createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  final user = FirebaseAuth.instance.currentUser;
  var pd = PetdbHandeler();
  var gauth = GoogleSignInProvider();
  CircelProgressHandeler c = CircelProgressHandeler();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            elevation: 0,
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
                  color: Colors.purple),
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
            child: SingleChildScrollView(
              child: Tab1(
                gauth: gauth,
                pd: pd,
                petname: widget.petname,
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
