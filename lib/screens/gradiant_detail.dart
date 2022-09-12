import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/detail_screen_bloc/detail_screen_bloc.dart';
import '../controllers/download_image_bloc/download_image_bloc.dart';
import '../widgets/detail_screen_widgets.dart';
import '../widgets/wallpaper_setter.dart';
import '../resources/resources.dart';
import '../widgets/bottom_sheet.dart';

class DetailGradiantScreen extends StatelessWidget {
  const DetailGradiantScreen({Key? key, required this.myColor})
      : super(key: key);
  final List<Color> myColor;

  Widget rowIcon(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () async {
              BlocProvider.of<DownloadImageBloc>(context)
                  .add(DownloadImageOfGradiant(color: myColor));
            },
            icon: icons(context, IconsResources().download)),
        IconButton(
            onPressed: () async {
              int? location = await bottomSheet(context,
                  TextResources().bottomSheetTitle, bottomSheetScreenData);
              if (location != null) {
                File file = await getWidgetToImage(myColor);
                wallpaperGradiantSetter(file, location);
              }
            },
            icon:
                icons(context, IconsResources().setWallpaperFromDetailScreen)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onLongPressStart: (start) =>
                BlocProvider.of<DetailScreenBloc>(context)
                    .add(OnTab(isVis: false)),
            onLongPressEnd: (end) => BlocProvider.of<DetailScreenBloc>(context)
                .add(OnTab(isVis: true)),
            child: Hero(tag: 1, child: containerBuilder(myColor)),
          ),
          BlocBuilder<DetailScreenBloc, DetailScreenState>(
            builder: (context, state) => (state is DetailScreenLoaded)
                ? backIcon(context, state.isVis)
                : backIcon(context, true),
          ),
          BlocBuilder<DetailScreenBloc, DetailScreenState>(
            builder: (context, state) => (state is DetailScreenLoaded)
                ? allIcons(context, state.isVis, rowIcon(context))
                : allIcons(context, true, rowIcon(context)),
          ),
        ],
      ),
    );
  }
}
