import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpy/controllers/detail_screen_bloc/detail_screen_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../controllers/favorite_bloc/favorite_bloc.dart';
import '../widgets/wallpaper_setter.dart';
import '../resources/resources.dart';
import '../models/data_model.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/network_image.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.dataModel}) : super(key: key);
  final DataModel dataModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

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
                    final tempDir = await getTemporaryDirectory();
                    final path = '${tempDir.path}/${widget.dataModel.name}';
                    await Dio().download(widget.dataModel.url, path);
                    GallerySaver.saveImage(path).whenComplete(() =>
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
                      wallpaperSetter(widget.dataModel.url, location);
                    }
                  },
                  icon: icons(
                      context, IconsResources().setWallpaperFromDetailScreen)),
              FavoriteIcon(dataModel: widget.dataModel)
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
            child: Hero(
              tag: widget.dataModel.name,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: networkImages(widget.dataModel.url, null),
              ),
            ),
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

Icon icons(context, IconData iconData) {
  return Icon(
    size: 30,
    iconData,
    color: BlocProvider.of<DarkModeBloc>(context).isDark
        ? ColorResources().detailScreenIconsDark
        : ColorResources().detailScreenIcons,
  );
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({Key? key, required this.dataModel}) : super(key: key);
  final DataModel dataModel;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            widget.dataModel.fav = !widget.dataModel.fav;
          });
          EasyDebounce.debounce(
              'debounce',
              const Duration(seconds: 1),
              () => BlocProvider.of<FavoriteBloc>(context).add(AddFavorite(
                  dataModel: widget.dataModel,
                  isFavorite: true,
                  category: null)));
        },
        icon: icons(
            context,
            (widget.dataModel.fav)
                ? IconsResources().removeFavorite
                : IconsResources().addFavorite));
  }
}

void snackBar(String data, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
}
