import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import '../models/data_model.dart';
import '../utils/firestore_database_calling.dart';
import '../utils/store_data.dart';
import '../resources/resources.dart';
import '../widgets/background_service.dart';
import '../widgets/dialog_box.dart';
import '../widgets/wallpaper_setter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int? time;
  int? screen;
  String? collection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listsTiles(TextResources().changeWallpaperTitle,
              TextResources().changeWallpaperDec),
          const Divider(thickness: 2),
          GestureDetector(
              onTap: () async {
                time = await dialog(context, TextResources().intervalTitle,
                    dialogDataForTimeLine);
              },
              child: listsTiles(
                  TextResources().intervalTitle, TextResources().intervalDec)),
          GestureDetector(
            onTap: () async {
              screen = await dialog(
                  context, TextResources().screenTitle, bottomSheetScreenData);
              setState(() {});
            },
            child: listsTiles(
              TextResources().screenTitle,
              (screen == null || screen == 3)
                  ? TextResources().screenDec
                  : (screen == 1)
                      ? TextResources().screenHomeDec
                      : TextResources().screenLockDec,
            ),
          ),
          GestureDetector(
            onTap: () async {
              collection = await dialog(context, TextResources().collectionTitle,
                  dialogDataForCollection);
            },
            child: listsTiles(
              TextResources().collectionTitle,
              TextResources().collectionDec,
            ),
          ),
          MaterialButton(
            onPressed: () async {
              List<DataModel> data = await FirebaseSave().getData();
              final pref = PreferenceServices();
              pref.setScreen(screen ?? 3);
              pref.setList(data);
              pref.setNo(1);
              wallpaperSetter(
                  data[0].url,
                  screen ?? 3);
              await AndroidAlarmManager.periodic(Duration(minutes: 1),
                  TextResources().androidAlarmManagerId, callWallpaperSetter);
            },
            child: Text(TextResources().startService),
          ),
          MaterialButton(
            onPressed: () async {
              await AndroidAlarmManager.cancel(
                  TextResources().androidAlarmManagerId);
            },
            child: Text(TextResources().stopService),
          )
        ],
      ),
    );
  }
}

ListTile listsTiles(String title, String dec) {
  return ListTile(
    title: Text(title),
    subtitle: Text(dec, maxLines: 5),
  );
}
