// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      id: json['image_id'] as int,
      name: json['image_name'] as String,
      uid: json['image_uid'] as String,
      category: (json['image_category'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fav: json['image_fav'] as bool,
      timestamp: DataModel._fromJson(json['image_timestamp'] as Timestamp),
      url: json['image_url'] as String,
      wallpy_unm: json['wallpy_unm'] as String,
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'image_id': instance.id,
      'image_name': instance.name,
      'image_uid': instance.uid,
      'image_url': instance.url,
      'wallpy_unm': instance.wallpy_unm,
      'image_category': instance.category,
      'image_fav': instance.fav,
      'image_timestamp': DataModel._toJson(instance.timestamp),
    };
