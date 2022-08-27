part of 'add_category_bloc.dart';

abstract class AddCategoryEvent {}

class AddCategory extends AddCategoryEvent {
  List<String> myCategory;

  AddCategory({required this.myCategory});
}
