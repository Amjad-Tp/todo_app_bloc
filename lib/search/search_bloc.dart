import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/services/api_services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiServices apiServices;
  SearchBloc(this.apiServices) : super(SearchInitial()) {
    on<SearchTodos>((event, emit) async {
      emit(SearchLoading());
      try {
        final todos = await apiServices.fetchTodos();
        final filteredTodos =
            todos
                .where(
                  (todo) => todo['title'].toLowerCase().contains(
                    event.query.toLowerCase(),
                  ),
                )
                .toList();

        emit(SearchLoaded(todos: filteredTodos));
      } catch (e) {
        emit(SearchError("Faild to Search Todos"));
      }
    });
  }
}
