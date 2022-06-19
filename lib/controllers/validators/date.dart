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

  static RemainingTime datetimeBetween(String fdate, String ftime) {
    // String fdate = "28/2/2022";
    // String ftime = "12:00 AM";
    var fdatelist = fdate.split("/");
    var ftimelisttemp = ftime.split(" ");
    var ftimelist = ftimelisttemp[0].split(":");
    print(fdatelist);
    print(ftimelist);
    print(ftimelisttemp);
    int hour = 0;
    int temp = 0;
    temp = int.parse(ftimelist[0]);
    if (ftimelisttemp[1] == 'AM') {
      print("inam");
      if (temp == 12) {
        hour = 0;
      } else {
        hour = temp;
      }
    } else {
      if (temp == 12) {
        hour = temp;
      } else {
        hour = temp + 12;
      }
    }
    print(hour);
    DateTime from;
    from = DateTime(
      int.parse(fdatelist[2]),
      int.parse(fdatelist[1]),
      int.parse(fdatelist[0]),
      hour,
      int.parse(ftimelist[1]),
    );

    DateTime to = DateTime.now();
    print(to);
    var d = (from.difference(to));
    print(d.inHours);
    print(d.inDays);
    int days = d.inDays;
    int dateminit = d.inMinutes;
    int hours = (dateminit - (days * 60 * 24)) ~/ 60;
    int minitus = (dateminit - (days * 60 * 24)) % 60;
    print(minitus.toString() + " " + hours.toString() + " " + days.toString());
    bool isoverdue = false;
    if (days.isNegative || hours.isNegative || minitus.isNegative) {
      isoverdue = true;
    }

    return (RemainingTime(
        days: days, hours: hours, minits: minitus, isoverdue: isoverdue));
  }

  static String getDateTimeId() {
    return DateTime.now()
        .toString()
        .replaceAll("-", "")
        .replaceAll(":", "")
        .replaceAll(" ", "")
        .replaceAll(".", "");
  }

  static GreteItem greeting() {
    String greeet = "";
    String greeeturl = "assets/icons/morning.png";
    var datetime = DateTime.now();
    int hour = datetime.hour;
    if (hour < 12) {
      greeet = "Good Morning";
      greeeturl = "assets/icons/morning.png";
    } else if (hour < 16) {
      greeet = "Good Affternoon";
      greeeturl = "assets/icons/morning.png";
    } else if (hour < 20) {
      greeet = "Good Evening";
      greeeturl = "assets/icons/evening.png";
    } else if (hour < 24) {
      greeet = "Good Night";
      greeeturl = "assets/icons/night.png";
    }
    return GreteItem(greate: greeet, url: greeeturl);
  }

  static timeBetween(String time, int days) {
    var divdetime = time.split(":");
    var datetime = DateTime.now();
    int chours = datetime.hour;
    int cminitus = datetime.minute;
    int ehours = divdetime[0] as int;
    int eminitus = divdetime[1] as int;
    List<int> between = [];

    if (days > 0) {
      between[0] = 24 - (max(ehours, chours) - min(ehours, chours));
    } else {
      between[0] = max(ehours, chours) - min(ehours, chours);
    }
    print(between);
  }
}

class RemainingTime {
  final int days;
  final int hours;
  final int minits;
  final bool isoverdue;

  RemainingTime({
    required this.days,
    required this.hours,
    required this.minits,
    required this.isoverdue,
  });
}

class GreteItem {
  final String greate;
  final String url;

  GreteItem({required this.greate, required this.url});
}
