import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/search/search_bloc.dart';
import 'package:todo_app/todo/todo_bloc.dart';
import 'package:todo_app/screens/add_todo_screen.dart';
import 'package:todo_app/widget/confirmation_alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //-----App Bar------
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),

      //---------Body--------
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (query) {
                if (query.isEmpty) {
                  context.read<TodoBloc>().add(LoadTodos());
                } else {
                  context.read<SearchBloc>().add(SearchTodos(query));
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, searchState) {
                if (searchState is SearchLoading) {
                  return ColorfulCircularProgressIndicator(
                    colors: [
                      Colors.blue,
                      Colors.red,
                      Colors.yellow,
                      Colors.green,
                    ],
                    indicatorWidth: 70,
                    indicatorHeight: 70,
                    strokeWidth: 5,
                  );
                } else if (searchState is SearchLoaded) {
                  return _buildTodo(searchState.todos);
                }
                return BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    if (state is TodoLoading) {
                      return const Center(
                        child: ColorfulCircularProgressIndicator(
                          colors: [
                            Colors.blue,
                            Colors.red,
                            Colors.yellow,
                            Colors.green,
                          ],
                          indicatorWidth: 70,
                          indicatorHeight: 70,
                          strokeWidth: 5,
                        ),
                      );
                    } else if (state is TodoLoaded) {
                      return _buildTodo(state.todos);
                    } else if (state is TodoError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text('No records'));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      //-----------Floating Action Button---------
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        label: Text("Add Todo", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[700],
        tooltip: 'Add Todo',
        icon: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  ListView _buildTodo(List<dynamic> todos) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFFEFEFEF),
          child: ListTile(
            title: Text(
              todos[index]['title'],
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            subtitle: Text(
              todos[index]['description'],
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.outlined(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (ctx) => AddTodoScreen(
                              id: todos[index]['_id'],
                              existingTitle: todos[index]['title'],
                              existingDescription: todos[index]['description'],
                            ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.blueGrey),
                ),
                IconButton.outlined(
                  onPressed: () async {
                    if (await confirmationAlert(context) == true) {
                      context.read<TodoBloc>().add(
                        DeleteTodo(todos[index]['_id']),
                      );
                    }
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
