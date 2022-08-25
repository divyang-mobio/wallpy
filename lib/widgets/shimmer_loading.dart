import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../resources/resources.dart';
import 'gridview.dart';
import 'news_listview.dart';

Shimmer shimmer(context, bool isGrid) {
  return Shimmer.fromColors(
      baseColor: BlocProvider.of<DarkModeBloc>(context).isDark
          ? ColorResources().shimmerBaseDark
          : ColorResources().shimmerBase,
      highlightColor: BlocProvider.of<DarkModeBloc>(context).isDark
          ? ColorResources().shimmerHighlightDark
          : ColorResources().shimmerHighlight,
      child: isGrid ? gridView([], null, true) : listView([], true));
}

Shimmer categoryShimmer(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: BlocProvider.of<DarkModeBloc>(context).isDark
          ? ColorResources().shimmerBaseDark
          : ColorResources().shimmerBase,
      highlightColor: BlocProvider.of<DarkModeBloc>(context).isDark
          ? ColorResources().shimmerHighlightDark
          : ColorResources().shimmerHighlight,
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.14,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                            //height: 100,
                            width: MediaQuery.of(context).size.width * 0.36),
                      ),
                    );
                  })),
          Expanded(child: shimmer(context, true)),
        ],
      ));
}
