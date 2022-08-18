import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpy/widgets/theme.dart';
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
  bool _service = false;
  int? time;
  int? screen;
  String? collection;

  Future<void> _onClickEnable(enabled) async {
    setState(() {
      _service = enabled;
    });
    if (enabled) {
      List<DataModel> data = await FirebaseSave().getData();
      final pref = PreferenceServices();
      pref.setScreen(screen ?? 3);
      pref.setList(data);
      pref.setNo(1);
      pref.setToggle(true);

      wallpaperSetter(data[0].url, screen ?? 3);
      await AndroidAlarmManager.periodic(const Duration(minutes: 1),
          TextResources().androidAlarmManagerId, callWallpaperSetter);
    } else {
      final pref = PreferenceServices();
      pref.setToggle(false);
      await AndroidAlarmManager.cancel(TextResources().androidAlarmManagerId);
    }
  }

  ListTile listsTiles(String title, String dec) {
    return ListTile(
      title: Text(title),
      subtitle: Text(dec, maxLines: 5),
    );
  }

  getToggleValue() async {
    final pref = PreferenceServices();
    _service = await pref.getToggle();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getToggleValue();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ListTile(
              title: Text(TextResources().changeWallpaperTitle),
              subtitle: Text(
                TextResources().changeWallpaperDec,
                maxLines: 5,
              ),
              trailing: Switch.adaptive(
                  value: _service,
                  onChanged: _onClickEnable,
                  activeColor: ColorResources().activeSwitch)),
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
              collection = await dialog(context,
                  TextResources().collectionTitle, dialogDataForCollection);
            },
            child: listsTiles(
              TextResources().collectionTitle,
              TextResources().collectionDec,
            ),
          ),
          const Divider(thickness: 2),
          const DarkTheme(),
        ],
      ),
    );
  }
}

class DarkTheme extends StatelessWidget {
  const DarkTheme({Key? key}) : super(key: key);
//
//   @override
//   State<DarkTheme> createState() => _DarkThemeState();
// }
//
// class _DarkThemeState extends State<DarkTheme> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(TextResources().darkModeTitle),
        trailing: Switch.adaptive(
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(value),
            activeColor: ColorResources().activeSwitch));
  }
}
