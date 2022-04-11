import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/circleprogress_area.dart';

class SingelPetTabBar extends StatelessWidget {
  final String petname;
  const SingelPetTabBar({
    Key? key,
    required this.petname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                contentPadding: EdgeInsets.only(
                    left: size.width * 0.035, right: size.width * 0.035),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.deepPurpleAccent,
                      Colors.purpleAccent,
                      Colors.deepPurple,
                    ],
                  ),
                ),
                height: size.height * 0.06,
                buttonMargin: EdgeInsets.only(left: size.width * 0.08),
                // backgroundColor: Colors.red,
                unselectedBackgroundColor: Colors.deepPurple.shade100,
                unselectedLabelStyle: GoogleFonts.balsamiqSans(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7)),
                labelStyle: GoogleFonts.balsamiqSans(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                radius: 20,
                tabs: [
                  Tab(
                    text: "Activities",
                    // child: Container(
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //           padding: EdgeInsets.only(
                    //               right: size.width * 0.02),
                    //           child: Image.asset(
                    //             "assets/icons/weighingmachinenon.png",
                    //             height: size.height * 0.05,
                    //           )),
                    //       Text(
                    //         "Activities",
                    //         style: GoogleFonts.balsamiqSans(
                    //             fontSize: size.width * 0.05,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.white),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                  Tab(
                    text: "Vitamins",
                  ),
                ],
              ),
              Container(
                height: size.height * 0.5,
                child: TabBarView(
                  children: <Widget>[
                    ProgressArea(petname: petname),
                    Center(
                      child: Text("screen stil developing"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
