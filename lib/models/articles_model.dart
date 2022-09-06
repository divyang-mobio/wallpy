import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'source_model.dart';

part 'articles_model.g.dart';

@JsonSerializable()
class Articles {
  String? author, title, description, url, urlToImage, content, publishedAt;
  Source? source;

  Articles(
      {this.title = "",
      this.author = "",
      this.url = "",
      this.description = "",
      this.content = "",
      this.publishedAt= "",
      this.urlToImage = "",
      this.source});

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
}
