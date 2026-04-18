// bai5/models/task_model.dart

class TaskModel {
  final int id;
  final String title;
  final bool completed;
  final int userId;

  const TaskModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as int? ?? 0,
        title: json['title'] as String? ?? '',
        completed: json['completed'] as bool? ?? false,
        userId: json['userId'] as int? ?? 0,
      );
}
