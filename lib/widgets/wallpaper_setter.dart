import 'dart:io';
// import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
// import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

wallpaperSetter(String url,int location) async {
  File cachedImage = await DefaultCacheManager().getSingleFile(url);
  try {
    /// tested not working
    // await Wallpaper.homeScreen(imageName: cachedImage.path);
    /// testing
    /// work very slow
    await AsyncWallpaper.setWallpaperFromFile(
      filePath: cachedImage.path,
      wallpaperLocation: 3,
    );
    /// testing working
    // await WallpaperManager.setWallpaperFromFile(cachedImage.path, location);
    /// not working in nayan sir mobile
    // await WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
    print("done");
  } catch (e) {
    print("error");
  }
}
