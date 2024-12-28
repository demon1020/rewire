// blocs/routines_state.dart
// blocs/routines_state.dart
import '../model/task_model.dart';

abstract class RoutineState {
  List<Routine> routines;

  RoutineState({required this.routines});
}

class RoutineInitialState extends RoutineState {
  RoutineInitialState() : super(routines: []);
}

class RoutineLoadedState extends RoutineState {
  RoutineLoadedState({required List<Routine> routines})
      : super(routines: routines);
}
