import 'package:flutter/cupertino.dart';
import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';

class CircelProgressHandeler {
  var pethandeler = PetdbHandeler();

  // CircelProgress
  weightprogress() {
    Future<List<Weight>> w = pethandeler.getweight("dulaj");
    print(w);

    //return 0;
  }
}

class CircelProgress {
  final String centerText;
  final String footerText;
  final Color color;
  final double progress;
  CircelProgress(this.centerText, this.footerText, this.color, this.progress);
}
