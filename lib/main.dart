import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/search/search_bloc.dart';
import 'package:todo_app/todo/todo_bloc.dart';
import 'package:todo_app/services/api_services.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiServices = ApiServices();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(apiServices)..add(LoadTodos()),
        ),
        BlocProvider(create: (context) => SearchBloc(apiServices)),
      ],
      child: MaterialApp(
        title: 'Simple Todo App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
