import 'dart:io';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart ' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/detail_screen_bloc/detail_screen_bloc.dart';
import '../controllers/download_image_bloc/download_image_bloc.dart';
import '../controllers/favorite_bloc/favorite_bloc.dart';
import '../widgets/detail_screen_widgets.dart';
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

String text = '';
String subject = '';
List<String> imagePaths = [];

class _DetailScreenState extends State<DetailScreen> {
  Widget rowIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () async {
              BlocProvider.of<DownloadImageBloc>(context)
                  .add(DownloadImageOfWallpaper(url: widget.dataModel.url));
            },
            icon: icons(context, IconsResources().download)),
        IconButton(
            onPressed: () async {
              int? location = await bottomSheet(context,
                  TextResources().bottomSheetTitle, bottomSheetScreenData);
              if (location != null) {
                wallpaperSetter(widget.dataModel.url, location);
              }
            },
            icon:
                icons(context, IconsResources().setWallpaperFromDetailScreen)),
        FavoriteIcon(dataModel: widget.dataModel),
        IconButton(onPressed: () => onShare(context), icon: Icon(Icons.share))
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

  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final imageUrl = Uri.parse(widget.dataModel.url.toString());
    final http.Response response = await http.get(imageUrl);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${widget.dataModel.name}.jpg';

    File file = await File(path).writeAsBytes(bytes);
    print('urllllll....... ${widget.dataModel.url}');
    print('imagePaths====${file.path}');
    await Share.shareFiles([path],
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
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
              const Duration(milliseconds:  10),
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
