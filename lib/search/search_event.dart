part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTodos extends SearchEvent {
  final String query;
  const SearchTodos(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearch extends SearchEvent {}
