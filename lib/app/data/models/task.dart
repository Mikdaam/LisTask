class Task {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

//<editor-fold desc="Data Methods">
  const Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todos,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          icon == other.icon &&
          color == other.color &&
          todos == other.todos);

  @override
  int get hashCode =>
      title.hashCode ^ icon.hashCode ^ color.hashCode ^ todos.hashCode;

  @override
  String toString() {
    return 'Task {title: $title, icon: $icon, color: $color, todos: $todos};';
  }

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'color': color,
      'todos': todos,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      icon: map['icon'] as int,
      color: map['color'] as String,
      todos: (map['todos'] ?? []) as List<dynamic>,
    );
  }

//</editor-fold>
}