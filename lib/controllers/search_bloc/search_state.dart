part of 'search_bloc.dart';

abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  List<Object> data;

  SearchLoaded({required this.data});
}

class SearchError extends SearchState {}
