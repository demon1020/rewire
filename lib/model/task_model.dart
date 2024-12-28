class Routine {
  String id;
  String name;
  bool isExpanded;
  List<Task> tasks;

  Routine(
      {required this.id,
      required this.name,
      required this.tasks,
      this.isExpanded = false});
}

class Task {
  String id;
  String name;
  bool isCompleted;

  Task({required this.id, required this.name, this.isCompleted = false});
}
