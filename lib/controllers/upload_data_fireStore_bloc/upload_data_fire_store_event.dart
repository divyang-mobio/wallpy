part of 'upload_data_fire_store_bloc.dart';

abstract class UploadDataFireStoreEvent {}

class UploadData extends UploadDataFireStoreEvent {
  String url, name, months;
  List<String> category;

  UploadData(
      {required this.url,
      required this.name,
      required this.category,
      required this.months});
}

class OnSubmitForUpload extends UploadDataFireStoreEvent {}
