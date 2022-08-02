
import 'package:shimmer/shimmer.dart';

import '../resources/resources.dart';
import 'gridview.dart';

Shimmer shimmer() {
  return Shimmer.fromColors(
      baseColor: ColorResources().shimmerBase,
      highlightColor: ColorResources().shimmerHighlight,
      child: gridView([], null, true));
}