import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/setting_model.dart';

bottomSheet(context, String title, List<SettingModel> bottomSheetData) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      child: CupertinoActionSheet(
        title: Text(title, style: Theme.of(context).textTheme.headline5),
        actions: <CupertinoActionSheetAction>[
          for (var data in bottomSheetData)
            CupertinoActionSheetAction(
              child: Text(data.title),
              onPressed: () => Navigator.pop(context, data.onclick),
            ),
        ],
      ),
    );
  } else {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title, style: Theme.of(context).textTheme.headline5),
                    for (var data in bottomSheetData)
                      MaterialButton(
                        child: Text(data.title),
                        onPressed: () => Navigator.pop(context, data.onclick),
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
