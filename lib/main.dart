// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/widgets/input_dialog.dart';

import 'bloc/routine_bloc.dart';
import 'bloc/routine_event.dart';
import 'bloc/routine_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => RoutinesBloc())],
      child: MaterialApp(
        title: 'Routine Manager',
        home: RoutinesScreen(),
      ),
    );
  }
}

class RoutinesScreen extends StatelessWidget {
  final ExpansionTileController controller = ExpansionTileController();

  RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoutinesBloc(),
      child: BlocConsumer<RoutinesBloc, RoutineState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RoutineInitialState) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Routines and Tasks"),
              ),
              body: Center(child: Text("No routines yet.")),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await addRoutine(context);
                },
                child: Icon(Icons.add),
              ),
            );
          } else if (state is RoutineLoadedState) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Routines and Tasks"),
              ),
              body: ListView.builder(
                itemCount: state.routines.length,
                itemBuilder: (context, index) {
                  final routine = state.routines[index];
                  return ExpansionTile(
                    onExpansionChanged: (value) {
                      routine.isExpanded = value;
                    },
                    controller: ExpansionTileController(),
                    initiallyExpanded: routine.isExpanded,
                    leading: IconButton(
                      onPressed: () {
                        addTaskToRoutine(context, state, index);
                      },
                      icon: Icon(Icons.add),
                    ),
                    title: Text(routine.name),
                    children: routine.tasks.map((task) {
                      return ListTile(
                        title: Text(
                          task.name,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            context.read<RoutinesBloc>().add(
                                  ToggleTaskCompletionEvent(
                                    routine.id,
                                    task.id,
                                  ),
                                );
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await addRoutine(context);
                },
                child: Icon(Icons.add),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<void> addTaskToRoutine(
      BuildContext context, RoutineLoadedState state, int index) async {
    String? taskName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const InputDialog(
          title: 'Task Name',
          hint: 'Type your text here',
        );
      },
    );
    if (taskName != null && taskName.isNotEmpty) {
      context.read<RoutinesBloc>().add(
            AddTaskEvent(
              state.routines[index].id,
              taskName,
            ),
          );
    }
  }

  Future<void> addRoutine(BuildContext context) async {
    String? routineName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const InputDialog(
          title: 'Routine Name',
          hint: 'Type your text here',
        );
      },
    );
    if (routineName != null && routineName.isNotEmpty) {
      context.read<RoutinesBloc>().add(AddRoutineEvent(routineName));
    }
  }
}
