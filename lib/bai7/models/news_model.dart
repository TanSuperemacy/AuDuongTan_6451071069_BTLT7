// bai7/models/news_model.dart

class NewsModel {
  final int id;
  final String title;
  final String body;
  final int userId;

  const NewsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'] as int? ?? 0,
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        userId: json['userId'] as int? ?? 0,
      );
}
