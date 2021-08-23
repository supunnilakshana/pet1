import 'dart:ui';

import 'package:flutter/material.dart';

import 'Textfiledcontainer.dart';
import 'constansts.dart';

class RoundedPasswordfiled extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final Function(String) change;
  // final Function(String) onchange;
  // final ValueChanged<String> onChange;
  const RoundedPasswordfiled({
    Key? key,
    this.hintText = "Password",
    this.icon = Icons.lock,
    required this.change, //required this.onchange,
  }) : super(key: key);

  @override
  _RoundedPasswordfiledState createState() => _RoundedPasswordfiledState();
}

class _RoundedPasswordfiledState extends State<RoundedPasswordfiled> {
  bool isHidepassword = true;

  @override
  Widget build(BuildContext context) {
    return Textfiledcontainer(
      child: TextField(
        obscureText: isHidepassword,
        onChanged: widget.change,
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: kprimaryColor),
            suffixIcon:
                InkWell(onTap: _viewPassword, child: Icon(Icons.visibility)),
            hintText: widget.hintText,
            border: InputBorder.none),
      ),
    );
  }

  void _viewPassword() {
    if (isHidepassword == true) {
      isHidepassword = false;
    } else {
      isHidepassword = true;
    }
    setState(() {});
  }
}
