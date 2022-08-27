import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/resources.dart';

alertDialog(context, String title) {
  if (Platform.isIOS) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            actions: [
              CupertinoDialogAction(
                  child: Text(TextResources().alertBox),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  } else {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            actions: <Widget>[
              ElevatedButton(
                child: Text(TextResources().alertBox),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
