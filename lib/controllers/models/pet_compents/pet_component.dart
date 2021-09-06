class Weight {
  final String dateTime;
  final double weight;

  Weight(this.dateTime, this.weight);

  Map<String, dynamic> toMap() => {"date": this.dateTime, "value": this.weight};

  Weight.fromMap(Map<dynamic, dynamic> map)
      : dateTime = map["date"] as String,
        weight = map["value"] as double;
}
