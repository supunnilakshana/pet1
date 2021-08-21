import 'package:flutter/material.dart';

import 'Textfiledcontainer.dart';
import 'constansts.dart';

class RoundedPasswordfiled extends StatelessWidget {
  final String hintText;
  final IconData icon;
  // final ValueChanged<String> onChange;
  const RoundedPasswordfiled({
    Key? key,
    this.hintText = "Password",
    this.icon = Icons.lock,
    //  required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Textfiledcontainer(
      child: TextField(
        obscureText: true,
        //  onChanged: onChange,
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: kprimaryColor),
            suffixIcon: Icon(Icons.visibility),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
