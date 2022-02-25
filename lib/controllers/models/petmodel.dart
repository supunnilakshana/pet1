class Pet {
  final String id;
  final String name;
  final String type;
  final int spec;
  final String dob;
  final String color;
  final int gender;
  final String imgurl;

  Pet(
      {required this.id,
      required this.name,
      required this.type,
      required this.spec,
      required this.dob,
      required this.color,
      required this.gender,
      required this.imgurl});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "type": this.type,
        "spec": this.spec,
        "dob": this.dob,
        "color": this.color,
        "gender": this.gender,
        "imageurl": this.imgurl
      };

  Pet.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"] as String,
        type = map["type"] as String,
        spec = map["spec"] as int,
        dob = map["dob"] as String,
        color = map["color"] as String,
        gender = map["gender"] as int,
        imgurl = map["imageurl"];
}
