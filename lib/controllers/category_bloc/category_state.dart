part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  List<dynamic> data;

  CategoryLoaded({required this.data});
}

class CategoryError extends CategoryState {}
