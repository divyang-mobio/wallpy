
// import 'package:wallpaper_manager/wallpaper_manager.dart';
// import 'package:async_wallpaper/async_wallpaper.dart';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

wallpaperSetter(String path) async {
  print(path);
  // String url = path;  // Image url

  File cachedImage = await DefaultCacheManager().getSingleFile(path); //image file

  print(cachedImage);
  int location = WallpaperManagerFlutter.BOTH_SCREENS;  //Choose screen type

  try {
    await WallpaperManagerFlutter().setwallpaperfromFile(cachedImage,
        location); // Wrap with try catch for error management.
  }catch(e){
    print("error");
  }
    // int location = AsyncWallpaper.BOTH_SCREENS;
  //
  // final String result = await AsyncWallpaper.setWallpaper(path, location);
      // path, location);// WallpaperManager.setWallpaperFromFile(path, location);
  // print(result);
}