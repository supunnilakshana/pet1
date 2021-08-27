import 'package:flutter/material.dart';
import 'package:pet1/screens/add_pet/add_pet_screen.dart';

import 'backgound.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Image.asset(
              "assets/images/dog.jpg",
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
                "assets/images/cat.jpg",
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
