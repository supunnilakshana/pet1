import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';

class CircelProgressHandeler {
  var pethandeler = PetdbHandeler();

  // CircelProgress
  Future<CircelProgress> weightprogress() async {
    List<Weight> w = await pethandeler.getweight("dulaj");

    return CircelProgress(
        w.last.value.toString(), "Weight", Colors.lightGreen, 1);
  }
}

class CircelProgress {
  final String centerText;
  final String footerText;
  final Color color;
  final double progress;
  CircelProgress(this.centerText, this.footerText, this.color, this.progress);
}
