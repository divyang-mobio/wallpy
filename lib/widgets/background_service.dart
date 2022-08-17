import 'package:shared_preferences/shared_preferences.dart';
import '../utils/store_data.dart';
import 'wallpaper_setter.dart';

Future<void> callWallpaperSetter() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final preference = PreferenceServices();
  int no = await preference.getNo(sharedPreferences);
  int screen = await preference.getScreen(sharedPreferences);
  List url = await preference.getList(sharedPreferences);
  if (no == (url.length)) {
    no = 0;
  }
  wallpaperSetter(url[no], screen);
  preference.setNo(++no);
}
