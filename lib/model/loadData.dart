class LoadData {
  final int userId;
  final int id;
  final String title;
  final String body;

  LoadData(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
