part of 'news_category_bloc.dart';

abstract class NewsCategoryState {}

class NewsCategoryLoading extends NewsCategoryState {}

class NewsCategoryLoaded extends NewsCategoryState {
  List<Articles> data;

  NewsCategoryLoaded({required this.data});
}

class NewsCategoryError extends NewsCategoryState {
  String? error;

  NewsCategoryError({this.error});
}
