import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/dashboard/compt/backgound.dart';
import 'package:pet1/screens/login/loginscreen.dart';

import 'compt/circleprogress_area.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    Key? key,
    required this.petname,
  }) : super(key: key);

  final String petname;

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final user = FirebaseAuth.instance.currentUser;
  var gauth = GoogleSignInProvider();
  late String greate;
  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setdisplayname();
    greate = Date.greeting();
    return Scaffold(
      appBar: AppBar(
          actions: [
            Container(
              margin: EdgeInsets.only(top: 2, right: 5),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: size.width * 0.08,
                backgroundImage: NetworkImage(user!.photoURL.toString()),
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_open_sharp,
              color: kprimaryColor.withOpacity(0.8),
              size: size.width * 0.1,
            ),
          )),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            Container(
              width: size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.06, top: size.height * 0.03),
                    child: Row(
                      children: [
                        Text(
                          'Hello ' + name,
                          style: TextStyle(
                              fontSize: size.width * 0.09,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.06, top: size.height * 0.008),
                    child: Row(
                      children: [
                        Text(
                          greate,
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: Card(
                        shadowColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        color: kmenucolor,
                        child: ListTile(
                          leading: Container(
                            child: Image.asset(
                              "assets/images/dog.png",
                            ),
                          ),
                          title: Text(
                            "Blacky Vaccine Day",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Icon(Icons.timer, color: Colors.yellowAccent),
                                Text(" remaining time",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.05, top: size.height * 0.045),
                    child: Row(
                      children: [
                        Text(
                          "  My Pets",
                          style: TextStyle(
                              fontSize: size.width * 0.075,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: size.width * 0.06),
                                  child: Container(
                                    child: Image.asset(
                                      'assets/icons/addpeticon.png',
                                      width: size.width * 0.15,
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03,
                        right: size.width * 0.03,
                        top: size.height * 0.04),
                    child: Container(
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: size.width / size.height * 1.45,
                        crossAxisCount: 2,
                        mainAxisSpacing: size.height * 0.01,
                        crossAxisSpacing: size.width * 0.03,
                        shrinkWrap: true,
                        children: List.generate(
                          5,
                          (index) {
                            bool status;

                            return SingelPetItem();
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  setdisplayname() {
    String tempname = user!.displayName!;
    var list = tempname.split(" ");
    name = list[0];
    setState(() {});
  }
}

class SingelPetItem extends StatelessWidget {
  const SingelPetItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: GestureDetector(
            onTap: () {
              // Image.network(
              //   fiximagelink + data[index].image,
              // ),

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Singelitemfull(
              //               imglist: imglist,
              //               product: data[index],
              //             )));
            },
            child: Container(
              // color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.shade100,
                            blurRadius:
                                2.0, // has the effect of softening the shadow
                            spreadRadius:
                                2.0, // has the effect of extending the shadow
                            offset: Offset(
                              3.0, // horizontal, move right 10
                              3.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                        child: Image.asset("assets/images/previewdog1.jpg"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.01),
                    child: Text(
                      "  My Pets",
                      style: TextStyle(
                          fontSize: size.width * 0.07,
                          color: kprimaryColor.withOpacity(0.8),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            )));
  }
}

// Expanded(child: ProgressArea(petname: petname)),

/* RoundedButton(
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

                // WeightInput.popupWeight(context, petname);
                List<Weight> weightlist = await pd.getweight(petname);
                weightlist.forEach((element) {
                  print(element.dateTime);
                });
              },
            )*/
