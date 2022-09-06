import 'dart:ffi';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:wallpy/widgets/detail_screen_widgets.dart';
import '../resources/resources.dart';
import 'alert_box.dart';

wallpaperSetter(String url, int location) async {
  File cachedImage = await DefaultCacheManager().getSingleFile(url);
  try {
    await WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
  } catch (e) {
    null;
  }
}

wallpaperGradiantSetter(context, File file, int location) async {
  try {
    await WallpaperManagerFlutter()
        .setwallpaperfromFile(file, location)
        .whenComplete(() => toast(TextResources().successWallpaperSetting));
  } catch (e) {
    alertDialog(context, TextResources().errorWallpaperSetting);
  }
}
