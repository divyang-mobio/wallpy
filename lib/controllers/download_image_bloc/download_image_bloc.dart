import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../widgets/detail_screen_widgets.dart';

part 'download_image_event.dart';

part 'download_image_state.dart';

class DownloadImageBloc extends Bloc<DownloadImageEvent, DownloadImageState> {
  DownloadImageBloc() : super(DownloadImageInitial()) {
    on<DownloadImageOfGradiant>((event, emit) async {
      File file = await getWidgetToImage(event.color);
      GallerySaver.saveImage(file.path);
    });
    on<DownloadImageOfWallpaper>((event, emit) async {
      File cachedImage = await DefaultCacheManager().getSingleFile(event.url);
      GallerySaver.saveImage(cachedImage.path);
    });
  }
}
