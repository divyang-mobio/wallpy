part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  List<Object> data;

  FavoriteLoaded({required this.data});
}

class FavoriteError extends FavoriteState {}

