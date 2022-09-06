import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel {
  @JsonKey(name: 'image_id')
  int id;
  @JsonKey(name: 'image_name')
  String name;
  @JsonKey(name: 'image_uid')
  String uid;
  @JsonKey(name: 'image_url')
  String url;
  @JsonKey(name: 'wallpy_unm')
  String wallpy_unm;
  @JsonKey(name: 'image_category')
  List<String> category;
  @JsonKey(name: 'image_fav')
  bool fav;
  @JsonKey(fromJson: _fromJson, toJson: _toJson, name: 'image_timestamp')
  DateTime timestamp;

  DataModel(
      {required this.id,
      required this.name,
      required this.uid,
      required this.category,
      required this.fav,
      required this.timestamp,
      required this.url,
      required this.wallpy_unm});

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  static DateTime _fromJson(Timestamp date) =>
      DateTime.parse(date.toDate().toString());

  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
