class LoggedUser {
  final String email;
  final int petcount;
  final List<String> petList;

  LoggedUser(
      {required this.email, required this.petcount, required this.petList});

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      email: json["email"],
      petcount: json["petcount"],
      petList: json["petlist"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'petcount': petcount,
      'petlist': petcount,
    };
  }
}
