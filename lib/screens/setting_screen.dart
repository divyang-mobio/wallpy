import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/firestore_database_calling.dart';
import '../utils/store_data.dart';
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
  String? collection;

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
            final pref = PreferenceServices();
            pref.setScreen(screen ?? 3);
            pref.setList(RepositoryProvider.of<FirebaseDatabase>(context).data);
            pref.setNo(0);
            await AndroidAlarmManager.periodic(Duration(minutes: time ?? 15),
                TextResources().androidAlarmManagerId, callWallpaperSetter);
          },
          child: const Text("Start service"),
        ),
        MaterialButton(
          onPressed: () async {
            await AndroidAlarmManager.cancel(
                TextResources().androidAlarmManagerId);
          },
          child: const Text("stop service"),
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
