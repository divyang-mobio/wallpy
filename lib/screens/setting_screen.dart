import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../widgets/background_service.dart';
import '../widgets/dialog_box.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int? time;
  int? screen;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            (screen == null)
                ? TextResources().screenDec
                : (screen == 3)
                    ? TextResources().screenDec
                    : (screen == 1)
                        ? TextResources().screenHomeDec
                        : TextResources().screenLockDec,
          ),
        ),
        MaterialButton(
          onPressed: () async {
            await AndroidAlarmManager.periodic(const Duration(minutes: 1),
                            TextResources().androidAlarmManagerId, callWallpaperSetter);
          },
          child: const Text("Start service"),
        )
      ],
    );
  }
}

ListTile listsTiles(String title, String dec) {
  return ListTile(
    title: Text(title),
    subtitle: Text(dec, maxLines: 5),
  );
}
