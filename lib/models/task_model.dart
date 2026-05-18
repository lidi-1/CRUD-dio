class Task {

  final int id;

  final String todo;

  final bool completed;

  Task({
    required this.id,
    required this.todo,
    required this.completed,
  });

  factory Task.fromJson(
      Map<String, dynamic> json) {

    return Task(
      id: json['id'],

      todo: json['todo'],

      completed: json['completed'],
    );
  }

  Task copyWith({
    int? id,
    String? todo,
    bool? completed,
  }) {

    return Task(
      id: id ?? this.id,

      todo: todo ?? this.todo,

      completed:
          completed ?? this.completed,
    );
  }
}