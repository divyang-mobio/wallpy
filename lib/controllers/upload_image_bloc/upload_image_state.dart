part of 'upload_image_bloc.dart';

abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoaded extends UploadImageState {
  String url, name;

  UploadImageLoaded({required this.url, required this.name});
}

class OnUploadButtonClick extends UploadImageState {}

class UploadImageError extends UploadImageState {}

