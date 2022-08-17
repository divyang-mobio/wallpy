part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchData extends SearchEvent {
  String query;
  bool isFavorite;
  bool isSearch;
  FirebaseDatabase firebaseDatabase;

  SearchData(
      {required this.query, required this.isFavorite, required this.isSearch , required this.firebaseDatabase});
}
