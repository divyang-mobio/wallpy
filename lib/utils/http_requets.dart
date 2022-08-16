import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';

class HttpRequests {
  Future<WeatherApiResModel> determinePosition() async {
    Position position = await reqPermission();
    print('${position.latitude}to${position.longitude}');

    const String key = 'abc3f51546a80dcdd3213fcae70951d9';

    var lat = position.latitude.toString();
    var long = position.longitude.toString();

    try {
      final String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key";
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      var weatherData = WeatherApiResModel.fromMap(json);
      // ignore: avoid_print
      print(weatherData.toMap());
      return weatherData;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }

  Future<Position> reqPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // ignore: avoid_print
    print('${position.latitude}to${position.longitude}');

    return position;
  }
}
