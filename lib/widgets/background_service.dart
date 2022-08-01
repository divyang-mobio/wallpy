import 'package:firebase_core/firebase_core.dart';
import '../models/data_model.dart';
import '../utils/firestore_database_calling.dart';

// class BackgroundService {
//   MethodChannel methodChannel =
//       MethodChannel(TextResources().methodChannelName);
//
//   void startService() async {
//     String value = await methodChannel
//         .invokeMethod(TextResources().methodChannelCallingServiceName);
//     print(value);
//   }
//   void stopService() async {
//     String value = await methodChannel
//         .invokeMethod(TextResources().methodChannelStopServiceName);
//     print(value);
//   }
// }


Future<void> callWallpaperSetter() async {
  await Firebase.initializeApp();
  List<DataModel> data = await FirebaseDatabase().getAllData(null);
  print(data);
}