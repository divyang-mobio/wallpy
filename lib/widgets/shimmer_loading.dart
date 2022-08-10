import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpy/screens/category_screen.dart';
import '../resources/resources.dart';
import 'gridview.dart';

Shimmer shimmer() {
  return Shimmer.fromColors(
      baseColor: ColorResources().shimmerBase,
      highlightColor: ColorResources().shimmerHighlight,
      child: gridView([], null, true));
}

Shimmer categoryshimmer(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: ColorResources().shimmerBase,
      highlightColor: ColorResources().shimmerHighlight,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(19.0),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
          );
        },
      ));
}
