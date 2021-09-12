import 'package:pet1/controllers/models/pet_compents/pet_component.dart';

class Pet {
  String _id = "";
  String _name = "";
  String _type = "";
  int _spec = 0;
  String _dob = "";
  String _color = "";
  List<Weight> _weight = [];
  List<Event> _events = [];
  List<String> _bath = [];
  List<String> _teeth = [];
  List<String> _hair = [];
  List<String> _workout = [];

  List<String> get workout => _workout;

  set workout(List<String> value) {
    _workout = value;
  }

  List<Vaccine> _vaccines = [];
  List<Vitamin> _vitamins = [];

  List<Weight> get weight => _weight;

  List<Event> get events => _events;

  set events(List<Event> value) {
    _events = value;
  }

  set weight(List<Weight> value) {
    _weight = value;
  }

  int _gender = 0;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  List<String> get bath => _bath;

  set bath(List<String> value) {
    _bath = value;
  }

  String get name => _name;

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

  List<String> get teeth => _teeth;

  set teeth(List<String> value) {
    _teeth = value;
  }

  List<String> get hair => _hair;

  set hair(List<String> value) {
    _hair = value;
  }

  List<Vaccine> get vaccines => _vaccines;

  set vaccines(List<Vaccine> value) {
    _vaccines = value;
  }

  List<Vitamin> get vitamins => _vitamins;

  set vitamins(List<Vitamin> value) {
    _vitamins = value;
  }
}
