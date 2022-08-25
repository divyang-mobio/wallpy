import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
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

  Future<File> getWidgetToImage() async {
    final controller = ScreenshotController();
    final bytes = await controller
        .captureFromWidget(containerBuilder());
    final tempDir = await getTemporaryDirectory();
    final file =
    File('${tempDir.path}/$generateRandomString.png');
    return await file.writeAsBytes(bytes);
  }

  Widget containerBuilder() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: widget.myColor)),
    );
  }

  Widget rowIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () async {
              snackBar(TextResources().downloadImage, context);
              File file = await getWidgetToImage();
              GallerySaver.saveImage(file.path).whenComplete(() =>
                  snackBar(TextResources().successDownloaded, context));
            },
            icon: icons(context, IconsResources().download)),
        IconButton(
            onPressed: () async {
              int? location = await bottomSheet(
                  context,
                  TextResources().bottomSheetTitle,
                  bottomSheetScreenData);
              if (location != null) {
                File file = await getWidgetToImage();
                wallpaperGradiantSetter(file, location);
              }
            },
            icon: icons(
                context, IconsResources().setWallpaperFromDetailScreen)),
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
            child: Hero(tag: 1, child: containerBuilder()),
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

String generateRandomString() {
  var r = Random();
  String randomString =
      String.fromCharCodes(List.generate(5, (index) => r.nextInt(33) + 89));
  return randomString;
}
