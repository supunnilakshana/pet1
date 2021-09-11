import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';

class CircelProgressHandeler {
  var pethandeler = PetdbHandeler();

  // CircelProgress
  Future<CircelProgress> weightprogress() async {
    List<Weight> w = await pethandeler.getweight("dulaj");
    CircelProgress c = CircelProgress();
    c.centerText = "center";
    c.footerText = "Weight";
    c.progress = 1.0;
    c.color = Colors.blue;
    return c;
  }

  Future<CircelProgress> bathtprogress() async {
    CircelProgress c = CircelProgress();
    List<String> b = await pethandeler.getBath("sukku");
    print(Date.daysBetween(Date.convertDatetime(b.last)));
    c.centerText = "center";
    c.footerText = "Weight";
    c.progress = 1.0;
    c.color = Colors.blue;
    return c;
  }
}

class CircelProgress {
  String centerText = "loading";
  String footerText = "loading";
  Color color = Colors.amber;
  double progress = 1.0;
}
