class Weight {
  final String id;
  final String dateTime;
  final double value;

  Weight(this.id, this.dateTime, this.value);

  Map<String, dynamic> toMap() =>
      {'id': this.id, "date": this.dateTime, "value": this.value};

  Weight.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        dateTime = map["date"] as String,
        value = map["value"] as double;
}

class Vaccine {
  final String id;
  final String name;
  final String vacDate;
  final int status;

  Vaccine(this.id, this.name, this.vacDate, this.status);

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "vaccinedtDate": this.vacDate,
        "status": this.status,
      };
  Vaccine.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        name = map["name"] as String,
        vacDate = map["vaccinedtDate"] as String,
        status = map["status"] as int;
}

class Vitamin {
  final String id;
  final String name;
  final String vitDate;
  final int status;

  Vitamin(this.id, this.name, this.vitDate, this.status);

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "vitamintDate": this.vitDate,
        "status": this.status,
      };
  Vitamin.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        name = map["name"] as String,
        vitDate = map["vitamintDate"] as String,
        status = map["status"] as int;
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final String eventDate;
  final String eventtime;
  final String createDatetime;
  int status;

  EventModel(this.id, this.title, this.description, this.eventDate,
      this.eventtime, this.createDatetime, this.status);

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "title": this.title,
        "description": this.description,
        "eventDate": this.eventDate,
        "eventtime": this.eventtime,
        "createDate": this.createDatetime,
        "status": this.status,
      };

  EventModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        title = map["title"] as String,
        description = map["description"] as String,
        eventDate = map["eventDate"] as String,
        eventtime = map["eventtime"] as String,
        createDatetime = map["createDate"] as String,
        status = map["status"] as int;
}

class PetDayActivity {
  final List<String> bath;
  final List<String> teeth;
  final List<String> hair;
  final List<String> workout;

  PetDayActivity(
      {required this.bath,
      required this.teeth,
      required this.hair,
      required this.workout});

  Map<String, dynamic> toMap() => {
        "bath": this.bath,
        "teeth": this.teeth,
        "hair": this.hair,
        "workout": this.workout,
      };

  PetDayActivity.fromMap(Map<dynamic, dynamic> map)
      : bath = List<String>.from(map["bath"]),
        teeth = List<String>.from(map["teeth"]),
        hair = List<String>.from(map["hair"]),
        workout = List<String>.from(map["workout"]);
}
