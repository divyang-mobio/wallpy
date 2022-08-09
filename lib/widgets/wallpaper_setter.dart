import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

wallpaperSetter(String url, int location) async {
  File cachedImage = await DefaultCacheManager().getSingleFile(url);
  try {
    // await WallpaperManager.setWallpaperFromFile(cachedImage.path, location);
    /// not working in nayan sir mobile
    await WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
    print("done");
  } catch (e) {
    if (kDebugMode) {
      print("error");
    }
  }
}
