import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';

class CircelProgressHandeler {
  var pethandeler = PetdbHandeler();

  // CircelProgress
  Future<CircelProgress> weightprogress(String doc) async {
    List<Weight> w = await pethandeler.getweight(doc);
    CircelProgress c = CircelProgress();
    c.centerText = "center";
    c.footerText = "Weight";
    c.progress = 1.0;
    c.color = Colors.blue;
    return c;
  }

  Future<CircelProgress> bathtprogress(String doc) async {
    CircelProgress c = CircelProgress();
    List<String> b = await pethandeler.getBath(doc);
    print(b);
    if (b.isNotEmpty) {
      int count = Date.daysBetween(Date.convertDatetime(b.last));
      if (count <= 2) {
        c.centerText = "fresh";
        c.progress = 1.0;
        c.color = Colors.blue;
      } else if (count <= 7) {
        c.centerText = "clean";
        c.progress = 0.5;
        c.color = Colors.yellowAccent;
      } else {
        c.centerText = "dirty";
        c.progress = 0.2;
        c.color = Colors.red;
      }
    } else {
      c.centerText = "Tap";
      c.progress = 0.0;
      c.color = Colors.white54;
    }
    c.footerText = "Bath";
    return c;
  }
}

class CircelProgress {
  String centerText = "";
  String footerText = "";
  Color color = Colors.white60;
  double progress = 1.0;
}
