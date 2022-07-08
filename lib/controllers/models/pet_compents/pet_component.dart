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
  final String dose;
  final String vitCreateDate;
  String vitNextDate;
  final int vid;
  final List<VaccineSub> vaccinelist;

  Vaccine(
      {required this.id,
      required this.name,
      required this.dose,
      required this.vitCreateDate,
      required this.vitNextDate,
      required this.vid,
      required this.vaccinelist});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "dose": this.dose,
        "vitCreateDate": this.vitCreateDate,
        "vitNextDate": this.vitNextDate,
        "vid": this.vid,
        "vlist": this.vaccinelist
      };
  Vaccine.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        name = map["name"] as String,
        dose = map["dose"] as String,
        vitCreateDate = map["vitCreateDate"] as String,
        vitNextDate = map["vitNextDate"] as String,
        vid = map["vid"] as int,
        vaccinelist = (map["vlist"] as List)
            .map((item) => VaccineSub.fromMap(item))
            .toList();
}

class VitaminHistoryModel {
  final String id;
  final String dateTime;
  final String vitaminid;
  final String vitaminname;

  VitaminHistoryModel(
      {required this.id,
      required this.dateTime,
      required this.vitaminid,
      required this.vitaminname,
      vaccineid,
      vaccinename});

  Map<String, dynamic> toMap() => {
        'id': this.id,
        "date": this.dateTime,
        "vitaminid": this.vitaminid,
        'vitaminname': this.vitaminname
      };

  VitaminHistoryModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        dateTime = map["date"] as String,
        vitaminid = map["vitaminid"] as String,
        vitaminname = map["vitaminname"] as String;
}

class Vitamin {
  final String id;
  final String name;
  final String description;
  final String vitCreateDate;
  String vitNextDate;
  String vitNextTime;
  final int repatestatus;
  final int repatecount;
  final String repatetype;

  Vitamin({
    required this.id,
    required this.name,
    required this.description,
    required this.vitCreateDate,
    required this.vitNextDate,
    required this.vitNextTime,
    required this.repatestatus,
    required this.repatecount,
    required this.repatetype,
  });

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "description": this.description,
        "vitCreateDate": this.vitCreateDate,
        "vitNextDate": this.vitNextDate,
        "vitNextTime": this.vitNextTime,
        "repatestatus": this.repatestatus,
        "repatecount": this.repatecount,
        "repatetype": this.repatetype,
      };
  Vitamin.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        name = map["name"] as String,
        description = map["description"] as String,
        vitCreateDate = map["vitCreateDate"] as String,
        vitNextDate = map["vitNextDate"] as String,
        vitNextTime = map["vitNextTime"] as String,
        repatestatus = map["repatestatus"] as int,
        repatecount = map["repatecount"] as int,
        repatetype = map["repatetype"] as String;
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final String eventDate;
  final String eventtime;
  final String createDatetime;
  final String eventDatetime;
  int status;

  EventModel(this.id, this.title, this.description, this.eventDate,
      this.eventtime, this.createDatetime, this.eventDatetime, this.status);

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "title": this.title,
        "description": this.description,
        "eventDate": this.eventDate,
        "eventtime": this.eventtime,
        "createDate": this.createDatetime,
        "eventDatetime": this.eventDatetime,
        "status": this.status,
      };

  EventModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        title = map["title"] as String,
        description = map["description"] as String,
        eventDate = map["eventDate"] as String,
        eventtime = map["eventtime"] as String,
        createDatetime = map["createDate"] as String,
        eventDatetime = map["eventDatetime"] as String,
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

class VaccineSub {
  final String id;
  final String dateTime;
  final int dose;

  VaccineSub(this.id, this.dateTime, this.dose);

  Map<String, dynamic> toMap() =>
      {'id': this.id, "date": this.dateTime, "dose": this.dose};

  VaccineSub.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"] as String,
        dateTime = map["date"] as String,
        dose = map["dose"] as int;
}

class VaccineHisotryItem {
  final String id;
  final String dateTime;
  final String vname;
  final int dose;

  VaccineHisotryItem(
      {required this.id,
      required this.vname,
      required this.dateTime,
      required this.dose});
}
