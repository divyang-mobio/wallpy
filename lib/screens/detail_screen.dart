import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpy/widgets/wallpaper_setter.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: networkImages(widget.dataModel.url),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorResources().detailScreenContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
              height: 80,
              width: MediaQuery.of(context).size.width * .8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        final tempDir = await getTemporaryDirectory();
                        final path = '${tempDir.path}/${widget.dataModel.name}';
                        await Dio().download(widget.dataModel.url, path);
                        GallerySaver.saveImage(path).whenComplete(
                          () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content:
                                Text("Save Image ${widget.dataModel.name}"),
                          )),
                        );
                      },
                      icon: Icon(
                        size: 30,
                        IconsResources().download,
                        color: ColorResources().detailScreenIcons,
                      )),
                  IconButton(
                      onPressed: () async {
                        final location = await bottomSheet(
                            context,
                            TextResources().bottomSheetTitle,
                            bottomSheetScreenData);
                        wallpaperSetter(widget.dataModel.url, location);
                      },
                      icon: Icon(
                        size: 30,
                        IconsResources().setWallpaperFromDetailScreen,
                        color: ColorResources().detailScreenIcons,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
