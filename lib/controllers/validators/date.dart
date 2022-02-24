import 'dart:math';

import 'package:intl/intl.dart';

class Date {
  static String getStringdate() {
    // String date="";
    var dateParse = DateTime.now();
    String date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return date;
  }

  static DateTime convertDatetime(String date) {
    var datetime = DateFormat('d/M/yyyy').parse(date);

    print(datetime);
    return datetime;
  }

  static int daysBetween(DateTime from) {
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime.now();
    return (to.difference(from).inDays);
  }

  static datetimeBetween() {
    DateTime from;
    from = DateTime(2021, 09, 26, 22, 15, 0);

    DateTime to = DateTime.now();
    var d = (to.difference(from));

    return (to.difference(from).inDays);
  }

  static String getDateTimeId() {
    return DateTime.now()
        .toString()
        .replaceAll("-", "")
        .replaceAll(":", "")
        .replaceAll(" ", "")
        .replaceAll(".", "");
  }

  static String greeting() {
    String greeet = "";
    var datetime = DateTime.now();
    int hour = datetime.hour;
    if (hour < 12) {
      greeet = "Good Morning";
    } else if (hour < 16) {
      greeet = "Good Affternoon";
    } else if (hour < 20) {
      greeet = "Good Evening";
    } else if (hour < 24) {
      greeet = "Good Night";
    }
    return greeet;
  }

  // static timeBetween(String time, int days) {
  //   var divdetime = time.split(":");
  //   var datetime = DateTime.now();
  //   int chours = datetime.hour;
  //   int cminitus = datetime.minute;
  //   int ehours = divdetime[0] as int;
  //   int eminitus = divdetime[1] as int;
  //   List<int> between = [];

  //   if (days > 0) {
  //     between[0] = 24 - (max(ehours, chours) - min(ehours, chours));
  //   } else {
  //     between[0] = max(ehours, chours) - min(ehours, chours);
  //   }
  //   print(between);
  // }

}
