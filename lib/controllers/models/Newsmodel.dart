class NewsModel {
  final String id;
  final String title;
  final String context;
  final String addeddate;
  String editeddate;
  final String imageurl;

  NewsModel(
      {required this.id,
      required this.title,
      required this.context,
      required this.addeddate,
      this.editeddate = "",
      required this.imageurl});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titel': title,
      'context': context,
      'addeddate': addeddate,
      'editeddate': editeddate,
      'imageurl': imageurl
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> res) {
    return NewsModel(
        id: res['id'],
        title: res['titel'],
        context: res['context'],
        addeddate: res['addeddate'],
        editeddate: res['editeddate'],
        imageurl: res['imageurl']);
  }
}
