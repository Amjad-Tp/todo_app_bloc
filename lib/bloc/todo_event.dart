part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;

  AddTodo({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class UpdateTodo extends TodoEvent {
  final String id;
  final String title;
  final String description;

  UpdateTodo({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}
