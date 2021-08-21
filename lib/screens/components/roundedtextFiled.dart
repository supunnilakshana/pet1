import 'package:flutter/material.dart';

import 'Textfiledcontainer.dart';
import 'constansts.dart';

class RoundedInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  // final ValueChanged<String> onChange;
  const RoundedInput({
    Key? key,
    this.hintText = "Your Email",
    this.icon = Icons.person, //this.onChange?,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Textfiledcontainer(
      child: TextField(
        // onChanged: onChange,
        decoration: InputDecoration(
            icon: Icon(icon, color: kprimaryColor),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
