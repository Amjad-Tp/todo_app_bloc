class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool isComplete;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      isComplete: json['is_completed'] ?? false,
    );
  }
}
