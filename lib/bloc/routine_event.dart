// blocs/routines_event.dart
abstract class RoutineEvent {}

class AddRoutineEvent extends RoutineEvent {
  final String name;

  AddRoutineEvent(this.name);
}

class AddTaskEvent extends RoutineEvent {
  final String routineId;
  final String taskName;

  AddTaskEvent(this.routineId, this.taskName);
}

class ToggleTaskCompletionEvent extends RoutineEvent {
  final String routineId;
  final String taskId;

  ToggleTaskCompletionEvent(this.routineId, this.taskId);
}

class RemoveTaskEvent extends RoutineEvent {
  final String routineId;
  final String taskId;

  RemoveTaskEvent(this.routineId, this.taskId);
}
