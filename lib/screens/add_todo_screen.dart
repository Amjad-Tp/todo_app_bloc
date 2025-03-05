import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/todo/todo_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  final String? id;
  final String? existingTitle;
  final String? existingDescription;

  AddTodoScreen({
    super.key,
    this.id,
    this.existingTitle,
    this.existingDescription,
  });

  final _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = existingTitle ?? '';
    _descriptionController.text = existingDescription ?? '';

    bool isEditing = id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Todo' : 'Add Todo'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                maxLength: 40,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Todo Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is Required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                maxLength: 200,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is Required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    if (isEditing) {
                      // Update existing todo
                      context.read<TodoBloc>().add(
                        UpdateTodo(
                          id: id!,
                          title: _titleController.text,
                          description: _descriptionController.text,
                        ),
                      );
                    } else {
                      // Add new todo
                      context.read<TodoBloc>().add(
                        AddTodo(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
