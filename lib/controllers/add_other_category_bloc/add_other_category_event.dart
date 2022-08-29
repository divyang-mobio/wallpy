part of 'add_other_category_bloc.dart';

abstract class AddOtherCategoryEvent {}

class AddNewCategory extends AddOtherCategoryEvent{
  String data;

  AddNewCategory({required this.data});
}

class ShowTextField extends AddOtherCategoryEvent{}

class RemoveCategory extends AddOtherCategoryEvent{}

class RemoveCategoryField extends AddOtherCategoryEvent{}

class SubmitNewCategory extends AddOtherCategoryEvent{}
