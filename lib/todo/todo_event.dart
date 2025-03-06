part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final bool isComplete;

  AddTodo({
    required this.title,
    required this.description,
    this.isComplete = false,
  });

  @override
  List<Object?> get props => [title, description, isComplete];
}

class UpdateTodo extends TodoEvent {
  final String id;
  final String title;
  final String description;
  final bool isComplete;

  UpdateTodo({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  });

  @override
  List<Object?> get props => [id, title, description, isComplete];
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}
