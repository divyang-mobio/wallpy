part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategory extends CategoryEvent {
  List<dynamic>? category;

  GetAllCategory({
    this.category,
  });
}
