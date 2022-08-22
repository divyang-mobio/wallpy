import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:wallpy/widgets/theme.dart';
import '../resources/resources.dart';

networkImages(String link) {
  return CachedNetworkImage(
    cacheManager:
        CacheManager(Config("test", stalePeriod: const Duration(days: 1))),
    imageUrl: link,
    fit: BoxFit.fill,
    placeholder: (context, url) => Image.asset(
        Provider.of<ThemeProvider>(context).isDarkMode
            ? TextResources().placeHolderForLoadingImageDark
            : TextResources().placeHolderForLoadingImage,
        fit: BoxFit.fill),
    errorWidget: (context, url, error) =>
        Image.asset(ImageResources().loadingError, fit: BoxFit.fill),
  );

  // return Image.network(
  //     errorBuilder: (context, exception, stackTree) =>
  //         Image.asset(ImageResources().loadingError, fit: BoxFit.fill),
  //     loadingBuilder: (context, child, loadingProgress) {
  //       return (loadingProgress == null)
  //           ? child
  //           : const Center(child: CircularProgressIndicator.adaptive());
  //     },
  //     fit: BoxFit.fill,
  //     link);
}
