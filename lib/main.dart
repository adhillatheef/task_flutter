import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/repository/repository.dart';
import 'package:task_flutter/screens/home_screen.dart';
import 'package:task_flutter/screens/splash_screen.dart';

import 'bloc/task_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository: TodoRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todos App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


