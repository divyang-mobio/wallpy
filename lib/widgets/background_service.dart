import 'package:firebase_core/firebase_core.dart';
import 'wallpaper_setter.dart';
import '../models/data_model.dart';
import '../utils/firestore_database_calling.dart';

Future<void> callWallpaperSetter() async {
  await Firebase.initializeApp();
  List<DataModel> data = await FirebaseDatabase().getAllData(null);
  wallpaperSetter(data.first.url, 3);
}