import 'package:shimmer/shimmer.dart';
import '../resources/resources.dart';
import 'gridview.dart';
import 'news_listview.dart';

Shimmer shimmer(bool isGrid) {
  return Shimmer.fromColors(
      baseColor: ColorResources().shimmerBase,
      highlightColor: ColorResources().shimmerHighlight,
      child: isGrid ? gridView([], null, true) : listView([], true));
}