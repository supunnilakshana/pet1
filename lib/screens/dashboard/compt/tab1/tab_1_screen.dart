import 'package:flutter/material.dart';
import 'package:pet1/controllers/authentication/google/GoogleSignAuth.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/screens/components/roundedbutton.dart';
import 'package:pet1/screens/dashboard/compt/backgound.dart';
import 'package:pet1/screens/dashboard/compt/weight_screen/weight_screen.dart';
import 'package:pet1/screens/login/loginscreen.dart';

import '../circleprogress_area.dart';
import 'compt/weight_input.dart';

class Tab1 extends StatelessWidget {
  const Tab1({
    Key? key,
    required this.gauth,
    required this.pd,
    required this.petname,
  }) : super(key: key);

  final String petname;
  final GoogleSignInProvider gauth;
  final PetdbHandeler pd;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        width: size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgressArea(petname: petname),
            RoundedButton(
              text: "Signout",
              onpress: () async {
                await gauth.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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

                // WeightInput.popupWeight(context, petname);
                List<Weight> weightlist = await pd.getweight(petname);
                weightlist.forEach((element) {
                  print(element.dateTime);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
