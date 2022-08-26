part of 'upload_image_bloc.dart';

abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoaded extends UploadImageState {
  String url;

  UploadImageLoaded({required this.url});
}

class UploadImageError extends UploadImageState {}
