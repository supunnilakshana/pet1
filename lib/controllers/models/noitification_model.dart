class NotificationModel {
  final String id;
  final String title;
  final String context;
  final String date;
  int status;
  final String imageurl;

  NotificationModel(
      {required this.id,
      required this.title,
      required this.context,
      required this.date,
      required this.status,
      this.imageurl = ""});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titel': title,
      'context': context,
      'date': date,
      'status': status,
      'imageurl': imageurl
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> res) {
    return NotificationModel(
        id: res['id'],
        title: res['titel'],
        context: res['context'],
        date: res['date'],
        status: res['status'],
        imageurl: res['imageurl']);
  }
}
