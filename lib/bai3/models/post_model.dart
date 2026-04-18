// bai3/models/post_model.dart

class PostModel {
  final int? id;
  final String title;
  final String body;
  final int userId;

  const PostModel({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as int?,
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        userId: json['userId'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'userId': userId,
      };
}
