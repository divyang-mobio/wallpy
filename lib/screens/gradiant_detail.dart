import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../controllers/detail_screen_bloc/detail_screen_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../widgets/wallpaper_setter.dart';
import '../resources/resources.dart';
import '../widgets/bottom_sheet.dart';
import 'detail_screen.dart';

class DetailGradiantScreen extends StatefulWidget {
  const DetailGradiantScreen({Key? key, required this.myColor})
      : super(key: key);
  final List<Color> myColor;

  @override
  State<DetailGradiantScreen> createState() => _DetailGradiantScreenState();
}

class _DetailGradiantScreenState extends State<DetailGradiantScreen> {
  Visibility backIcon(bool isVis) {
    return Visibility(
      maintainState: true,
      visible: isVis,
      child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(IconsResources().back,
                    color: BlocProvider.of<DarkModeBloc>(context).isDark
                        ? ColorResources().appBarTextIconDark
                        : ColorResources().appBarTextIcon)),
          )),
    );
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

  Visibility allIcons(bool isVis) {
    return Visibility(
      maintainState: true,
      visible: isVis,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
              color: BlocProvider.of<DarkModeBloc>(context).isDark
                  ? ColorResources().detailScreenContainerDark
                  : ColorResources().detailScreenContainer,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          height: 80,
          width: MediaQuery.of(context).size.width * .8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    snackBar(TextResources().downloadImage, context);
                    final controller = ScreenshotController();
                    final bytes =
                        await controller.captureFromWidget(containerBuilder());
                    final tempDir = await getTemporaryDirectory();
                    final file =
                        File('${tempDir.path}/$generateRandomString.png');
                    await file.writeAsBytes(bytes);
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
                      final controller = ScreenshotController();
                      final bytes = await controller
                          .captureFromWidget(containerBuilder());
                      final tempDir = await getTemporaryDirectory();
                      final file =
                          File('${tempDir.path}/$generateRandomString.png');
                      await file.writeAsBytes(bytes);
                      wallpaperGradiantSetter(file, location);
                    }
                  },
                  icon: icons(
                      context, IconsResources().setWallpaperFromDetailScreen)),
            ],
          ),
        ),
      ),
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
                ? backIcon(state.isVis)
                : backIcon(true),
          ),
          BlocBuilder<DetailScreenBloc, DetailScreenState>(
            builder: (context, state) => (state is DetailScreenLoaded)
                ? allIcons(state.isVis)
                : allIcons(true),
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
