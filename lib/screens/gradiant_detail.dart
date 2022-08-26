import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../controllers/detail_screen_bloc/detail_screen_bloc.dart';
import '../widgets/detail_screen_widgets.dart';
import '../widgets/wallpaper_setter.dart';
import '../resources/resources.dart';
import '../widgets/bottom_sheet.dart';

class DetailGradiantScreen extends StatefulWidget {
  const DetailGradiantScreen({Key? key, required this.myColor})
      : super(key: key);
  final List<Color> myColor;

  @override
  State<DetailGradiantScreen> createState() => _DetailGradiantScreenState();
}

class _DetailGradiantScreenState extends State<DetailGradiantScreen> {

  Widget rowIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () async {
              try {
                snackBar(TextResources().downloadImage, context);
                File file = await getWidgetToImage(widget.myColor);
                GallerySaver.saveImage(file.path).whenComplete(
                        () =>
                        snackBar(TextResources().successDownloaded, context));
              }catch (e) {
                print("error");
              }
            },
            icon: icons(context, IconsResources().download)),
        IconButton(
            onPressed: () async {
              int? location = await bottomSheet(context,
                  TextResources().bottomSheetTitle, bottomSheetScreenData);
              if (location != null) {
                File file = await getWidgetToImage(widget.myColor);
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
            child: Hero(tag: 1, child: containerBuilder(widget.myColor)),
          ),
          BlocBuilder<DetailScreenBloc, DetailScreenState>(
            builder: (context, state) => (state is DetailScreenLoaded)
                ? backIcon(context, state.isVis)
                : backIcon(context, true),
          ),
          BlocBuilder<DetailScreenBloc, DetailScreenState>(
            builder: (context, state) => (state is DetailScreenLoaded)
                ? allIcons(context, state.isVis, rowIcon())
                : allIcons(context, true, rowIcon()),
          ),
        ],
      ),
    );
  }
}
