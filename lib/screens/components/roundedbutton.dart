import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function? onpress;
  final Color color, textcolor;

  const RoundedButton({
    this.color = kprimaryColor,
    this.text = "",
    this.textcolor = Colors.white,
    Key? key,
    this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
      width: size.width * 0.8,
      height: size.height * 0.07,
      child: ClipRRect(
        child: TextButton(
          //
          onPressed: () {
            onpress!();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          child: Text(
            text,
            style: TextStyle(color: textcolor),
          ),
        ),
      ),
    );
  }
}
