part of 'upload_image_bloc.dart';

abstract class UploadImageEvent {}

class GetImageUrl extends UploadImageEvent {
  String url, name;

  GetImageUrl({required this.url, required this.name});
}

class NotGetImageUrl extends UploadImageEvent {}

class OnSubmit extends UploadImageEvent {}

class NotGivePermissionOrImage extends UploadImageEvent {}

class OnButtonClick extends UploadImageEvent {}