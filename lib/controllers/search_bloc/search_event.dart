part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchData extends SearchEvent {
  String query;
  bool isFavorite;
  bool isSearch;

  SearchData(
      {required this.query, required this.isFavorite, required this.isSearch});
}

class CleanData extends SearchEvent {}
