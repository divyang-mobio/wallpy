part of 'upload_data_fire_store_bloc.dart';

abstract class UploadDataFireStoreEvent {}

class UploadData extends UploadDataFireStoreEvent {
  String url, name;
  List<String> category;

  UploadData({required this.url, required this.name, required this.category});
}

class OnSubmitForUpload extends UploadDataFireStoreEvent {}
