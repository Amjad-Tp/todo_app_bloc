part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<dynamic> todos;

  TodoLoaded({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodoError extends TodoState {
  final String message;
  TodoError({required this.message});

  @override
  List<Object?> get props => [message];
}
