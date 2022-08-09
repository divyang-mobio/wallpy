import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data_model.dart';

class PreferenceServices {
  void setNo(int number) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setInt("number", number);
  }

  void setScreen(int screen) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setInt("screen", screen);
  }

  void setList(List<DataModel> data) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setStringList(
        "list", data.map((e) => e.url.toString()).toList());
    if (kDebugMode) {
      print("save");
    }
  }

  Future<int> getNo(SharedPreferences preferences) async {
    final no = preferences.getInt("number");
    return no ?? 0;
  }

  Future<int> getScreen(SharedPreferences preferences) async {
    final screen = preferences.getInt("screen");
    return screen ?? 3;
  }

  Future<List> getList(SharedPreferences preferences) async {
    final urlList = preferences.getStringList("list");
    return urlList ?? [];
  }
}
