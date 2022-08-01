import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:wallpy/models/setting_model.dart';

import '../resources/resources.dart';



bottomSheet(context, String title , List<SettingModel> bottomSheetData) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      child: CupertinoActionSheet(
        title: Text(title, style: Theme
            .of(context)
            .textTheme
            .headline6),
        actions: <CupertinoActionSheetAction>[
          for(var i in bottomSheetData)
          CupertinoActionSheetAction(
            child: Text(i.title),
            onPressed: () =>
                Navigator.pop(context , i.onclick),
          ),
        ],
      ),
    );
  } else {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title, style: Theme
                        .of(context)
                        .textTheme
                        .headline5),
                    for(var i in bottomSheetData)
                      MaterialButton(
                      child: Text(i.title),
                      onPressed: () =>
                          Navigator.pop(
                              context, i.onclick),
                    ),
                    // MaterialButton(
                    //   child: Text(lock),
                    //   onPressed: () =>
                    //       Navigator.pop(
                    //           context, WallpaperManagerFlutter.LOCK_SCREEN),
                    // ),
                    // MaterialButton(
                    //   child: Text(both),
                    //   onPressed: () =>
                    //       Navigator.pop(
                    //           context, WallpaperManagerFlutter.BOTH_SCREENS),
                    // )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
