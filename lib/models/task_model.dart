class TaskModel {
  String? id;
  String title;
  String description;
  String category;
  int priority;
  DateTime dueDate;
  String status; // e.g., Not Started, In Progress, Completed

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
    };
  }

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      priority: json['priority'],
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
    );
  }
}
