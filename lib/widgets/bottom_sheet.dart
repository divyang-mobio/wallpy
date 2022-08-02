import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/setting_model.dart';

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
