part of 'add_other_category_bloc.dart';

abstract class AddOtherCategoryState {}

class AddOtherCategoryInitial extends AddOtherCategoryState {}

class AddOtherCategoryShowTextField extends AddOtherCategoryState {}

class AddOtherCategoryData extends AddOtherCategoryState {
  String data;

  AddOtherCategoryData({required this.data});
}

class AddOtherCategoryError extends AddOtherCategoryState {}
