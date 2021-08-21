import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onpress;
  final Color color, textcolor;

  const RoundedButton({
    this.color = kprimaryColor,
    this.text = "",
    this.textcolor = Colors.white,
    Key? key,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      color: color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextButton(
          // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
          onPressed: () => onpress,
          child: Text(
            text,
            style: TextStyle(color: textcolor),
          ),
        ),
      ),
    );
  }
}
