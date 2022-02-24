import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';

class CircelProgressHandeler {
  var pethandeler = PetdbHandeler();

  // CircelProgress

  static CircelProgress  bathtprogress( List<String> b)  {
    CircelProgress c = CircelProgress();
    print(b);
    if (b.isNotEmpty) {
      int count = Date.daysBetween(Date.convertDatetime(b.last));
      if (count <= 2) {
        c.centerText = "Fresh";
        c.progress = 1.0;
        c.color = Colors.blue;
      } else if (count <= 7) {
        c.centerText = "Clean";
        c.progress = 0.5;
        c.color = Colors.yellowAccent;
      } else {
        c.centerText = "Dirty";
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

 static CircelProgress hairprogress( List<String> b)  {
    CircelProgress c = CircelProgress();
   
    print(b);
    if (b.isNotEmpty) {
      int count = Date.daysBetween(Date.convertDatetime(b.last));
      if (count <= 2) {
        c.centerText = "Stylish";
        c.progress = 1.0;
        c.color = Colors.blue;
      } else if (count <= 6) {
        c.centerText = "Clean";
        c.progress = 0.5;
        c.color = Colors.yellowAccent;
      } else {
        c.centerText = "Crazy";
        c.progress = 0.2;
        c.color = Colors.red;
      }
    } else {
      c.centerText = "Tap";
      c.progress = 0.0;
      c.color = Colors.white54;
    }
    c.footerText = "Hair";
    return c;
  }

 static CircelProgress teethProgress( List<String> b) {
    CircelProgress c = CircelProgress();
    
    print(b);
    if (b.isNotEmpty) {
      int count = Date.daysBetween(Date.convertDatetime(b.last));
      if (count <= 2) {
        c.centerText = "Fresh";
        c.progress = 1.0;
        c.color = Colors.blue;
      } else if (count <= 7) {
        c.centerText = "Clean";
        c.progress = 0.5;
        c.color = Colors.yellowAccent;
      } else {
        c.centerText = "Dirty";
        c.progress = 0.2;
        c.color = Colors.red;
      }
    } else {
      c.centerText = "Tap";
      c.progress = 0.0;
      c.color = Colors.white54;
    }
    c.footerText = "Teeth";
    return c;
  }

  static CircelProgress workoutProgress( List<String> b)  {
    CircelProgress c = CircelProgress();
    print(b);
    if (b.isNotEmpty) {
      int count = Date.daysBetween(Date.convertDatetime(b.last));
      if (count < 1) {
        c.centerText = "Happy";
        c.progress = 1.0;
        c.color = Colors.blue;
      } else if (count < 2) {
        c.centerText = "Saudade";
        c.progress = 0.5;
        c.color = Colors.yellowAccent;
      } else {
        c.centerText = "Unhappy";
        c.progress = 0.2;
        c.color = Colors.red;
      }
    } else {
      c.centerText = "Tap";
      c.progress = 0.0;
      c.color = Colors.white54;
    }
    c.footerText = "Workout";
    return c;
  }

  Future<CircelProgress> weightProgress(String doc) async {
    CircelProgress c = CircelProgress();
    List<Weight> b = await pethandeler.getweight(doc);
    print(b);
    if (b.isNotEmpty) {
      c.centerText = b.last.value.toString() + " kg";
      c.progress = 1;
      c.color = Colors.greenAccent;
    } else {
      c.centerText = "Tap";
      c.progress = 0.0;
      c.color = Colors.white54;
    }
    c.footerText = "Weight";
    return c;
  }
}

class CircelProgress {
  String centerText = "";
  String footerText = "";
  Color color = Colors.white60;
  double progress = 1.0;
}
