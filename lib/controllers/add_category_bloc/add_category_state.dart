part of 'add_category_bloc.dart';

abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoaded extends AddCategoryState {
  List<String> data;
  String select;

  AddCategoryLoaded(
      {required this.data, required this.select});
}

class AddCategoryError extends AddCategoryState {}
