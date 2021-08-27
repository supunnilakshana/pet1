import 'package:flutter/material.dart';

import 'compt/body.dart';

class AddPetscreen extends StatelessWidget {
  final int pet;
  AddPetscreen(this.pet);
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Body(
        pettype: pet,
      ),
    );
  }
}
