import 'package:intl/intl.dart';

class Date {
  static String getStringdate() {
    // String date="";
    var dateParse = DateTime.now();
    String date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return date;
  }

  static DateTime convertDatetime(String date) {
    String dateParse = "9/9/2021";

    var datetime = DateFormat('d/M/yyyy').parse(dateParse);

    print(datetime);
    return datetime;
  }
}
