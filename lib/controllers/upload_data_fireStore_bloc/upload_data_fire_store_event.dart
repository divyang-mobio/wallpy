part of 'upload_data_fire_store_bloc.dart';

abstract class UploadDataFireStoreEvent {}

class UploadData extends UploadDataFireStoreEvent {
  String url, name, month;
  List<String> category;

  UploadData(
      {required this.url,
      required this.name,
      required this.category,
      required this.month});
}

class OnSubmitForUpload extends UploadDataFireStoreEvent {}
