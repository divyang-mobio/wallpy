import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../resources/resources.dart';

networkImages(String link) {
  return CachedNetworkImage(
    imageUrl: link,
    fit: BoxFit.fill,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator.adaptive()),
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
