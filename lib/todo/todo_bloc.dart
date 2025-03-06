import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/services/api_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiServices;
  TodoBloc(this.apiServices) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await apiServices.fetchTodos();
        emit(TodoLoaded(todos: todos));
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        await apiServices.addTodo(
          event.title,
          event.description,
          event.isComplete,
        );
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });

    on<UpdateTodo>((event, emit) async {
      try {
        await apiServices.updateTodo(
          event.id,
          event.title,
          event.description,
          event.isComplete,
        );
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        await apiServices.deleteTodo(event.id);
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });
  }
}
