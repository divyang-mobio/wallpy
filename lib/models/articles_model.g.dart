// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
      title: json['title'] as String? ?? "",
      author: json['author'] as String? ?? "",
      url: json['url'] as String? ?? "",
      description: json['description'] as String? ?? "",
      content: json['content'] as String? ?? "",
      publishedAt: json['publishedAt'] == null
          ? ""
          : Articles._fromJson(json['publishedAt'] as String),
      urlToImage: json['urlToImage'] as String? ?? "",
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'content': instance.content,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
    };
