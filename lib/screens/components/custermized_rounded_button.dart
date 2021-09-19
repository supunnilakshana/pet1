import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';

class CustRoundedButton extends StatelessWidget {
  final String text;
  final Function? onpress;
  final Color color, textcolor;
  final double height, width;

  const CustRoundedButton({
    this.color = kprimaryColor,
    this.text = "",
    this.textcolor = Colors.white,
    Key? key,
    this.onpress,
    this.height = 10.2,
    this.width = 12.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
      width: width,
      height: height,
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
