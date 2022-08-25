part of 'data_fetch_bloc.dart';

abstract class DataFetchEvent {}

class GetAllData extends DataFetchEvent {
  String? category;
  bool isFavorite;

  GetAllData({this.category, required this.isFavorite});
}

class OnRefresh extends DataFetchEvent {
  bool isRefresh;

  OnRefresh({required this.isRefresh});
}

