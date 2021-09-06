import 'package:pet1/controllers/models/pet_compents/pet_component.dart';

class Pet {
  String _id = "";
  String _name = "";
  String _type = "";
  int _spec = 0;
  String _dob = "";
  String _color = "";
  int _teethcount = 0;
  // late List<Weight> _weight;

//  List<Weight> get weight => _weight;

  // set weight(List<Weight> value) {
  //   _weight = value;
  // }

  int _gender = 0;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  int get teethcount => _teethcount;

  set teethcount(int value) {
    _teethcount = value;
  }

  String get color => _color;

  set color(String value) {
    _color = value;
  }

  String get dob => _dob;

  set dob(String value) {
    _dob = value;
  }

  int get spec => _spec;

  set spec(int value) {
    _spec = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  set name(String value) {
    _name = value;
  }

  int get gender => _gender;

  set gender(int value) {
    _gender = value;
  }
}
