part of 'add_category_bloc.dart';

abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoaded extends AddCategoryState {
  List<String> myCategory;

  AddCategoryLoaded({required this.myCategory});
}

class AddCategoryError extends AddCategoryState {}
