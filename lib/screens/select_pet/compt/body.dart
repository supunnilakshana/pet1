import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet1/screens/add_pet/add_pet_screen.dart';
import 'package:pet1/screens/components/constansts.dart';

import 'backgound.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tap and select your  pet ",
            style: TextStyle(
                fontSize: size.width * 0.08, color: kheadingcolorlight),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          GestureDetector(
            child: Image.asset(
              "assets/images/dog.png",
              width: size.width * 0.5,
            ),
            onTap: () {
              print("dog");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddPetscreen(0);
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          GestureDetector(
              child: Image.asset(
                "assets/images/cat.png",
                width: size.width * 0.5,
              ),
              onTap: () {
                print("dog");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddPetscreen(1);
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
