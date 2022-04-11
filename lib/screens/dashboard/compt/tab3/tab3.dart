import 'package:flutter/material.dart';

import 'backgound.dart';

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "data sdsfddfgffgfgfghghghghghg ghhgh ghghghhgh ghg fddfdfd ddfdfdfdfdfdfdfdfd",
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade100,
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            )
                          ],
                        ),
                        child: Image.network(
                          "https://media.istockphoto.com/photos/generic-modern-suv-car-in-concrete-garage-picture-id1307086567",
                          fit: BoxFit.cover,
                        ))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
