import 'package:json_annotation/json_annotation.dart';

part 'source_model.g.dart';

@JsonSerializable()
class Source {
  String? id, name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
