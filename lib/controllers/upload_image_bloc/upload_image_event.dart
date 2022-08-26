part of 'upload_image_bloc.dart';

abstract class UploadImageEvent {}

class GetImageUrl extends UploadImageEvent {
  String url;

  GetImageUrl({required this.url});
}
