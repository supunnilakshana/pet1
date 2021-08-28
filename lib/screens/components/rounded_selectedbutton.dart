import 'package:flutter/material.dart';
import 'package:pet1/screens/components/constansts.dart';

class RoundedSelectButton extends StatelessWidget {
  final String text;
  final Function(BuildContext context) onpress;
  final Color color, textcolor;
  final IconData icon;

  const RoundedSelectButton({
    this.color = kprimarylightcolor,
    this.text = "",
    this.textcolor = Colors.black,
    Key? key,
    required this.onpress,
    required this.icon,
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
        child: ElevatedButton(
            //
            onPressed: () => onpress(context),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.date_range,
                  color: kprimaryColor,
                ),
                Text(" "),
                Text(
                  text,
                  style: TextStyle(
                      color: Color(0xFF47476b),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            )),
      ),
    );
  }
}
