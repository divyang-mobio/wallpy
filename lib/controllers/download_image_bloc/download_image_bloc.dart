import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';


import '../../resources/resources.dart';
import '../../widgets/detail_screen_widgets.dart';

part 'download_image_event.dart';

part 'download_image_state.dart';

class DownloadImageBloc extends Bloc<DownloadImageEvent, DownloadImageState> {
  DownloadImageBloc() : super(DownloadImageInitial()) {
    on<DownloadImageOfGradiant>((event, emit) async {
      try {
        toast(TextResources().downloadImage);
        File file = await getWidgetToImage(event.color);
        GallerySaver.saveImage(file.path)
            .whenComplete(() => toast(TextResources().successImgDownloaded));
      } catch (e) {
        toast(TextResources().errorImgDownloaded);
      }
    });
    on<DownloadImageOfWallpaper>((event, emit) async {
      try {
        toast(TextResources().downloadImage);
        File cachedImage = await DefaultCacheManager().getSingleFile(event.url);
        GallerySaver.saveImage(cachedImage.path)
            .whenComplete(() => toast(TextResources().successImgDownloaded));
      } catch (e) {
        toast(TextResources().errorImgDownloaded);
      }
    });
  }
}
