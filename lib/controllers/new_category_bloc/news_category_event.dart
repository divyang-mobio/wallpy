part of 'news_category_bloc.dart';

abstract class NewsCategoryEvent {}

class GetAllNewsCategoryData extends NewsCategoryEvent {
  String url;
  GetAllNewsCategoryData({required this.url});
}