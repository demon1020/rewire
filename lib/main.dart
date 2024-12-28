// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/pages/home_page.dart';

import 'bloc/routine_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => RoutinesBloc())],
      child: MaterialApp(
        title: 'Rewire',
        home: HomePage(),
      ),
    );
  }
}
