part of 'data_fetch_bloc.dart';

abstract class DataFetchState {}

class DataFetchLoading extends DataFetchState {}

class DataFetchLoaded extends DataFetchState {
  List<Object> data;

  DataFetchLoaded({required this.data});
}

class DataFetchError extends DataFetchState {}
