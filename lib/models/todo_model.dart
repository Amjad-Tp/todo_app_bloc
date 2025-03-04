class TodoModel {
  final int id;
  final String title;
  final String description;

  TodoModel({required this.id, required this.title, required this.description});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
    );
  }
}
