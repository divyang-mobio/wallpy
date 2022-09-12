import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../resources/resources.dart';

networkImages(String link, BoxFit? fit) {
  try {
    return CachedNetworkImage(
      cacheManager:
          CacheManager(Config("test", stalePeriod: const Duration(days: 1))),
      imageUrl: link,
      fit: fit ?? BoxFit.fill,
      placeholder: (context, url) => Image.asset(
          BlocProvider.of<DarkModeBloc>(context).isDark
              ? TextResources().placeHolderForLoadingImageDark
              : TextResources().placeHolderForLoadingImage,
          fit: BoxFit.fill),
      errorWidget: (context, url, error) =>
          Image.asset(ImageResources().loadingError, fit: fit ?? BoxFit.fill),
    );
  } catch (e) {
    return Image.asset(ImageResources().loadingError, fit: fit ?? BoxFit.fill);
  }
}
