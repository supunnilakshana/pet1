

class Pet {
  String _id = "";
  String _name = "";
  String _type="";
  int _spec=0;

  Pet(this._id, this._name, this._type, this._spec, this._age, this._weight);


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  int _age = 0;
  double _weight = 0.0;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get spec => _spec;

  set spec(int value) {
    _spec = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  double get weight => _weight;

  set weight(double value) {
    _weight = value;
  }


}
