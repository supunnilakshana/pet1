import 'package:flutter/material.dart';

import 'compt/body.dart';

class AddPetscreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final int pet;
  AddPetscreen(this.pet);
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        //resizeToAvoidBottomInset: false,
        body: Body(
          scaffoldKey: _scaffoldKey,
          pettype: pet,
        ),
      ),
    );
  }
}
