part of 'data_fetch_bloc.dart';

abstract class DataFetchEvent {}

class GetAllData extends DataFetchEvent {
  String? category;
  bool isFavorite;

  GetAllData({this.category,required this.isFavorite});
}
