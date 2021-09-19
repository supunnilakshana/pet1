import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PopupDialog {
  static showPopupDilog(BuildContext context, String titel, String description,
      Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnCancelText: "Not yet!",
      btnOkText: "Yes I did",
      btnCancelOnPress: () {},
      btnOkOnPress: actionFun,
    )..show();
  }

  static showPopuplogout(BuildContext context, String titel, String description,
      Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnCancelText: "No",
      btnOkText: "Yes",
      btnCancelOnPress: () {},
      btnOkOnPress: actionFun,
    )..show();
  }
}

























/*static Future<void> showMyDialog(BuildContext context, String titel,
      String description, Function actionFun) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titel),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes , did'),
              onPressed: () {
                /// actionFun();
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.LEFTSLIDE,
                  title: 'Dialog Title',
                  desc: 'Dialog description here.............',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
              },
            ),
            TextButton(
              child: const Text('Not yet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */