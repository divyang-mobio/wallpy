part of 'add_category_bloc.dart';

abstract class AddCategoryEvent {}

class ShowCategory extends AddCategoryEvent {}

class OnSelectCategory extends AddCategoryEvent {
  String myCategory;

  OnSelectCategory({required this.myCategory});
}

class OnSubmitCategory extends AddCategoryEvent {
  String data;

  OnSubmitCategory({required this.data});
}

