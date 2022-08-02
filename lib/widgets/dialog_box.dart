import 'dart:io';
import 'package:flutter/material.dart';
import '../models/setting_model.dart';

dialog(context, String title , List<SettingModel> dialogData) {
  if (Platform.isIOS) {
  } else {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(title, style: Theme.of(context).textTheme.headline5),
            children: <Widget>[
              for (var i in dialogData)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, i.onclick);
                  },
                  child: Text(i.title),
                ),
            ],
          );
        });
  }
}
