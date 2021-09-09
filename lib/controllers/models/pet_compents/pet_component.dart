class Weight {
  final String dateTime;
  final double value;

  Weight(this.dateTime, this.value);

  Map<String, dynamic> toMap() => {"date": this.dateTime, "value": this.value};

  Weight.fromMap(Map<dynamic, dynamic> map)
      : dateTime = map["date"] as String,
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

class Event {
  final String title;
  final String description;
  final String eventDatetime;
  final String createDatetime;
  final int status;

  Event(this.title, this.description, this.eventDatetime, this.createDatetime,
      this.status);

  Map<String, dynamic> toMap() => {
        "title": this.title,
        "description": this.description,
        "eventDate": this.eventDatetime,
        "createDate": this.createDatetime,
        "status": this.status,
      };

  Event.fromMap(Map<dynamic, dynamic> map)
      : title = map["title"] as String,
        description = map["description"] as String,
        eventDatetime = map["eventDate"] as String,
        createDatetime = map["createDate"] as String,
        status = map["status"] as int;
}
