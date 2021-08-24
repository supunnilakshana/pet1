import 'package:flutter/material.dart';

import 'Textfiledcontainer.dart';
import 'constansts.dart';

class RoundedInput extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;
  const RoundedInput({
    Key? key,
    this.hintText = "Your Email",
    this.icon = Icons.person,
    required this.onchange,
    required this.valid,
    required this.save,

    //this.onChange?,
  }) : super(key: key);

  @override
  _RoundedInputState createState() => _RoundedInputState();
}

class _RoundedInputState extends State<RoundedInput> {
  @override
  Widget build(BuildContext context) {
    return Textfiledcontainer(
      child: TextFormField(
        // onChanged: onChange,
        onChanged: widget.onchange,
        onSaved: widget.save,
        validator: widget.valid,
        decoration: InputDecoration(
            icon: Icon(widget.icon, color: kprimaryColor),
            hintText: widget.hintText,
            border: InputBorder.none),
      ),
    );
  }
}
