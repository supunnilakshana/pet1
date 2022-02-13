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
