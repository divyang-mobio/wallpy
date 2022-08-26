part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<dynamic> data;

  const CategoryLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class CategoryError extends CategoryState {
  final dynamic error;

  const CategoryError({required this.error});

  @override
  List<Object> get props => [error];
}
