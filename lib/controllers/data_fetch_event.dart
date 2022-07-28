part of 'data_fetch_bloc.dart';

abstract class DataFetchEvent {}

class GetAllData extends DataFetchEvent {}

class GetCategoryAllData extends DataFetchEvent {
  String category;

  GetCategoryAllData({required this.category});
}
