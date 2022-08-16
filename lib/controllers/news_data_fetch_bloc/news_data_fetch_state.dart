part of 'news_data_fetch_bloc.dart';

abstract class NewsDataFetchState {}

class NewsDataFetchLoading extends NewsDataFetchState {}

class NewsDataFetchLoaded extends NewsDataFetchState {
  List<Articles> data;

  NewsDataFetchLoaded({required this.data});
}

class NewsDataFetchError extends NewsDataFetchState {
  String? error;

  NewsDataFetchError({this.error});
}
