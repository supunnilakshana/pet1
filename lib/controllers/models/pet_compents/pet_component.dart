class Weight {
  final String dateTime;
  final double value;

  Weight(this.dateTime, this.value);

  Map<String, dynamic> toMap() => {"date": this.dateTime, "value": this.value};

  Weight.fromMap(Map<dynamic, dynamic> map)
      : dateTime = map["date"] as String,
        value = map["value"] as double;
}
