part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class GetFavoriteData extends FavoriteEvent {
  String? category;
  bool isFavorite;

  GetFavoriteData({this.category, required this.isFavorite});
}

class AddFavorite extends FavoriteEvent {
  DataModel dataModel;

  AddFavorite({required this.dataModel});
}
