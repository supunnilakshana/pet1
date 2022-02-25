import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet1/screens/add_pet/add_pet_screen.dart';
import 'package:pet1/screens/components/constansts.dart';

class SelectPetScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                child: SelectpetItem(
                  img: "assets/images/previewdog1.jpg",
                  titel: "Dog",
                  size: size,
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
                height: size.height * 0.05,
              ),
              GestureDetector(
                  child: SelectpetItem(
                    img: "assets/images/previewcat1.jpg",
                    titel: "Cat",
                    size: size,
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
        ),
      ),
    );
  }
}

class SelectpetItem extends StatelessWidget {
  final String titel;
  final String img;
  const SelectpetItem({
    Key? key,
    required this.size,
    required this.titel,
    this.img = "assets/images/previewdog1.jpg",
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.2,
        right: size.width * 0.2,
      ),
      child: Container(
        width: size.width * 0.6,
        // color: Colors.amber,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.05)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.shade100,
                      blurRadius: 2.0, // has the effect of softening the shadow
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.05)),
                  child: Image.asset(img),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: Text(
                titel,
                style: TextStyle(
                    fontSize: size.width * 0.07,
                    color: kprimaryColor.withOpacity(0.8),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
