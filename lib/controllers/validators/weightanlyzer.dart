import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pet1/controllers/validators/date.dart';

class WeightAnalyzer {
  static Future<void> getpetmWeight(
      String pettype, int spec, String bday) async {
    DateTime bdate = DateFormat('dd/MM/yyyy').parse(bday);
    final int weeks = Date.daysBetween(bdate) / 7 as int;
    final String response =
        await rootBundle.loadString('assets/data/dogdata.json');
    final data = await json.decode(response);
    var dlist = data[spec.toString()];
  }

  static getpetage() {}
}
