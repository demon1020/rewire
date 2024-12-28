import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/model/task_model.dart';

import 'routine_event.dart';
import 'routine_state.dart';

class RoutinesBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutinesBloc() : super(RoutineInitialState()) {
    on<AddRoutineEvent>((AddRoutineEvent event, Emitter<RoutineState> emit) {
      _addRoutine(event, emit);
    });

    on<AddTaskEvent>((AddTaskEvent event, Emitter<RoutineState> emit) {
      _addTask(event, emit);
    });

    on<ToggleTaskCompletionEvent>(
        (ToggleTaskCompletionEvent event, Emitter<RoutineState> emit) {
      _toggleTaskCompletion(event, emit);
    });

    on<RemoveTaskEvent>((RemoveTaskEvent event, Emitter<RoutineState> emit) {
      _removeTask(event, emit);
    });
  }

  // Method to handle adding a new routine
  void _addRoutine(AddRoutineEvent event, Emitter<RoutineState> emit) {
    List<Routine> routines = List.from(state.routines);
    routines.add(Routine(id: getId(), name: event.name, tasks: []));
    emit(RoutineLoadedState(routines: routines));
  }

  // Method to handle adding a new task to a specific routine
  void _addTask(AddTaskEvent event, Emitter<RoutineState> emit) {
    List<Routine> routines = List.from(state.routines);
    Routine routine = _getRoutineById(routines, event.routineId);
    routine.isExpanded = true;
    routine.tasks.add(Task(id: getId(), name: event.taskName));
    emit(RoutineLoadedState(routines: routines));
  }

  // Method to toggle task completion for a specific task in a routine
  void _toggleTaskCompletion(
      ToggleTaskCompletionEvent event, Emitter<RoutineState> emit) {
    List<Routine> routines = List.from(state.routines);
    Routine routine = _getRoutineById(routines, event.routineId);
    Task task = _getTaskById(routine, event.taskId);
    task.isCompleted = !task.isCompleted;
    emit(RoutineLoadedState(routines: routines));
  }

  // Method to handle removing a task from a specific routine
  void _removeTask(RemoveTaskEvent event, Emitter<RoutineState> emit) {
    List<Routine> routines = List.from(state.routines);
    Routine routine = _getRoutineById(routines, event.taskId);
    routine.tasks.removeWhere((t) => t.id == event.taskId);
    emit(RoutineLoadedState(routines: routines));
  }

  // Helper method to get a routine by name
  Routine _getRoutineById(List<Routine> routines, String id) {
    return routines.firstWhere((r) => r.id == id);
  }

  // Helper method to get a task by name from a routine
  Task _getTaskById(Routine routine, String id) {
    return routine.tasks.firstWhere((t) => t.id == id);
  }

  String getId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
