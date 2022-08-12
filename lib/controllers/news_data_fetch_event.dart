part of 'news_data_fetch_bloc.dart';

abstract class NewsDataFetchEvent {}

class GetAllNewsData extends NewsDataFetchEvent {
  String url;
  GetAllNewsData({required this.url});
}
