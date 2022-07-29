import 'package:flutter/services.dart';
import '../resources/resources.dart';

class BackgroundService {
  MethodChannel methodChannel =
      MethodChannel(TextResources().methodChannelName);

  void startService() async {
    String value = await methodChannel
        .invokeMethod(TextResources().methodChannelCallingServiceName);
    print(value);
  }
  void stopService() async {
    String value = await methodChannel
        .invokeMethod(TextResources().methodChannelStopServiceName);
    print(value);
  }
}
