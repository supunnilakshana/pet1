import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/errorpage.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/dashboard/compt/backgound.dart';
import 'package:pet1/screens/login/loginscreen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen_new.dart';

import 'compt/circleprogress_area.dart';
import 'compt/singelpetitem.dart';

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
  late Future<List<Pet>> futureData;
  final user = FirebaseAuth.instance.currentUser;
  var gauth = GoogleSignInProvider();
  late String greate;
  String name = "";

  @override
  void initState() {
    futureData = FireDBHandeler.getallPets();
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
                            borderRadius: BorderRadius.circular(20)),
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
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectPetScreenNew()));
                                    },
                                    child: Container(
                                      child: Image.asset(
                                        'assets/icons/addpeticon.png',
                                        width: size.width * 0.15,
                                      ),
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
                          child: FutureBuilder(
                        future: futureData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Pet> data = snapshot.data as List<Pet>;
                            print(data.length);

                            if (data.length > 0) {
                              return Container(
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio:
                                      size.width / size.height * 1.1,
                                  crossAxisCount: 2,
                                  // mainAxisSpacing: size.height * 0.01,
                                  crossAxisSpacing: size.width * 0.03,
                                  shrinkWrap: true,
                                  children: List.generate(
                                    data.length,
                                    (index) {
                                      bool status;

                                      return SingelPetItem(pet: data[index]);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Lottie.asset(
                                      "assets/animations/emptybox.json",
                                      width: size.width * 0.8));
                            }
                          } else if (snapshot.hasError) {
                            return Errorpage(size: size.width * 0.7);
                          }
                          // By default show a loading spinner.
                          return Center(
                              child: Lottie.asset(
                                  "assets/animations/loadingdots.json",
                                  width: size.width * 0.6));
                        },
                      )))
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

  loaddata() {
    futureData = FireDBHandeler.getallPets();
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
