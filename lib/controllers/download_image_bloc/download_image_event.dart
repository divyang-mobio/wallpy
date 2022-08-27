part of 'download_image_bloc.dart';

abstract class DownloadImageEvent {}

class DownloadImageOfGradiant extends DownloadImageEvent{
  List<Color> color;

  DownloadImageOfGradiant({required this.color});
}

class DownloadImageOfWallpaper extends DownloadImageEvent{
  String url;

  DownloadImageOfWallpaper({required this.url});
}
