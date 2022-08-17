import 'dart:convert';

WeatherApiResModel weatherApiResModelFromMap(String str) =>
    WeatherApiResModel.fromMap(json.decode(str));

String weatherApiResModelToMap(WeatherApiResModel data) =>
    json.encode(data.toMap());

class WeatherApiResModel {
  WeatherApiResModel({
    this.coord,
    required this.weather,
    required this.base,
    this.main,
    required this.visibility,
    this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final Coord? coord;
  final List<Weather> weather;
  final String base;
  final Main? main;
  final int visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int dt;
  final Sys? sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  factory WeatherApiResModel.fromMap(Map<String, dynamic> json) =>
      WeatherApiResModel(
        coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
        weather: json["weather"] == null
            ? []
            : List<Weather>.from(
                json["weather"].map((x) => Weather.fromMap(x))),
        base: json["base"] ?? '',
        main: json["main"] == null ? null : Main.fromMap(json["main"]),
        visibility: json["visibility"] ?? 0,
        wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
        dt: json["dt"] ?? 0,
        sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
        timezone: json["timezone"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        cod: json["cod"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "coord": coord?.toMap(),
        "weather": weather != null
            ? List<dynamic>.from(weather.map((x) => x.toMap()))
            : [],
        "base": base,
        "main": main == null ? null : main!.toMap(),
        "visibility": visibility,
        "wind": wind?.toMap(),
        "clouds": clouds?.toMap(),
        "dt": dt,
        "sys": sys?.toMap(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  final int all;

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
        all: json["all"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "all": all,
      };
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  final double lon;
  final double lat;

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lon: json["lon"] == null ? 0 : json["lon"].toDouble(),
        lat: json["lat"] == null ? 0 : json["lat"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json["temp"] == null ? 0 : json["temp"].toDouble(),
        feelsLike:
            json["feels_like"] == null ? 0 : json["feels_like"].toDouble(),
        tempMin: json["temp_min"] == null ? 0 : json["temp_min"].toDouble(),
        tempMax: json["temp_max"] == null ? 0 : json["temp_max"].toDouble(),
        pressure: json["pressure"] ?? 0,
        humidity: json["humidity"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.message,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final int type;
  final int id;
  final double message;
  final String country;
  final int sunrise;
  final int sunset;

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        type: json["type"] ?? 0,
        id: json["id"] ?? 0,
        message: json["message"] == null ? 0 : json["message"].toDouble(),
        country: json["country"] ?? "",
        sunrise: json["sunrise"] ?? 0,
        sunset: json["sunset"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "message": message,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"] ?? 0,
        main: json["main"] ?? "",
        description: json["description"] ?? "",
        icon: json["icon"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  final double speed;
  final int deg;

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"] == null ? 0 : json["speed"].toDouble(),
        deg: json["deg"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "speed": speed,
        "deg": deg,
      };
}

// To parse this JSON data, do
//
//     final weatherApiResModel = weatherApiResModelFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// WeatherApiResModel weatherApiResModelFromMap(String str) =>
//     WeatherApiResModel.fromMap(json.decode(str));

// String weatherApiResModelToMap(WeatherApiResModel data) =>
//     json.encode(data.toMap());

// class WeatherApiResModel {
//   WeatherApiResModel({
//     required this.city,
//     required this.cod,
//     required this.message,
//     required this.cnt,
//     required this.list,
//   });

//   final City? city;
//   final String cod;
//   final double message;
//   final int cnt;
//   final List<ListElement> list;

//   factory WeatherApiResModel.fromMap(Map<String, dynamic> json) =>
//       WeatherApiResModel(
//         city: json["city"] == null ? null : City.fromMap(json["city"]),
//         cod: json["cod"] == null ? null : json["cod"],
//         message: json["message"] == null ? null : json["message"].toDouble(),
//         cnt: json["cnt"] == null ? null : json["cnt"],
//         list: json["list"] != null
//             ? List<ListElement>.from(
//                 json["list"].map((x) => ListElement.fromMap(x)))
//             : [],
//       );

//   Map<String, dynamic> toMap() => {
//         "city": city == null ? null : city?.toMap(),
//         "cod": cod == null ? null : cod,
//         "message": message == null ? null : message,
//         "cnt": cnt == null ? null : cnt,
//         "list":
//             list != null ? List<dynamic>.from(list.map((x) => x.toMap())) : [],
//       };
// }

// class City {
//   City({
//     required this.id,
//     required this.name,
//     required this.coord,
//     required this.country,
//     required this.population,
//     required this.timezone,
//   });

//   final int id;
//   final String name;
//   final Coord coord;
//   final String country;
//   final int population;
//   final int timezone;

//   factory City.fromMap(Map<String, dynamic> json) => City(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         coord: Coord.fromMap(json["coord"]),
//         country: json["country"] == null ? null : json["country"],
//         population: json["population"] == null ? null : json["population"],
//         timezone: json["timezone"] == null ? null : json["timezone"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "coord": coord.toMap(),
//         "country": country == null ? null : country,
//         "population": population == null ? null : population,
//         "timezone": timezone == null ? null : timezone,
//       };
// }

// class Coord {
//   Coord({
//     required this.lon,
//     required this.lat,
//   });

//   final double lon;
//   final double lat;

//   factory Coord.fromMap(Map<String, dynamic> json) => Coord(
//         lon: json["lon"] == null ? null : json["lon"].toDouble(),
//         lat: json["lat"] == null ? null : json["lat"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "lon": lon == null ? null : lon,
//         "lat": lat == null ? null : lat,
//       };
// }

// class ListElement {
//   ListElement({
//     required this.dt,
//     required this.sunrise,
//     required this.sunset,
//     this.temp,
//     this.feelsLike,
//     required this.pressure,
//     required this.humidity,
//     required this.weather,
//     required this.speed,
//     required this.deg,
//     required this.gust,
//     required this.clouds,
//     required this.pop,
//   });

//   final int dt;
//   final int sunrise;
//   final int sunset;
//   final Temp? temp;
//   final FeelsLike? feelsLike;
//   final double pressure;
//   final int humidity;
//   final List<Weather> weather;
//   final double speed;
//   final int deg;
//   final double gust;
//   final int clouds;
//   final double pop;

//   factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
//         dt: json["dt"] == null ? null : json["dt"],
//         sunrise: json["sunrise"] == null ? null : json["sunrise"],
//         sunset: json["sunset"] == null ? null : json["sunset"],
//         temp: json["temp"] == null ? null : Temp.fromMap(json["temp"]),
//         feelsLike: json["feels_like"] == null
//             ? null
//             : FeelsLike.fromMap(json["feels_like"]),
//         pressure: json["pressure"] == null ? null : json["pressure"].toDouble(),
//         humidity: json["humidity"] == null ? null : json["humidity"],
//         weather: json["weather"] != null
//             ? List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x)))
//             : [],
//         speed: json["speed"] == null ? null : json["speed"].toDouble(),
//         deg: json["deg"] == null ? null : json["deg"],
//         gust: json["gust"] == null ? null : json["gust"].toDouble(),
//         clouds: json["clouds"] == null ? null : json["clouds"],
//         pop: json["pop"] == null ? null : json["pop"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "dt": dt == null ? null : dt,
//         "sunrise": sunrise == null ? null : sunrise,
//         "sunset": sunset == null ? null : sunset,
//         "temp": temp == null ? null : temp?.toMap(),
//         "feels_like": feelsLike == null ? null : feelsLike?.toMap(),
//         "pressure": pressure == null ? null : pressure,
//         "humidity": humidity == null ? null : humidity,
//         "weather": weather != null
//             ? List<dynamic>.from(weather.map((x) => x.toMap()))
//             : [],
//         "speed": speed == null ? null : speed,
//         "deg": deg == null ? null : deg,
//         "gust": gust == null ? null : gust,
//         "clouds": clouds == null ? null : clouds,
//         "pop": pop == null ? null : pop,
//       };
// }

// class FeelsLike {
//   FeelsLike({
//     required this.day,
//     required this.night,
//     required this.eve,
//     required this.morn,
//   });

//   final double day;
//   final double night;
//   final double eve;
//   final double morn;

//   factory FeelsLike.fromMap(Map<String, dynamic> json) => FeelsLike(
//         day: json["day"] == null ? null : json["day"].toDouble(),
//         night: json["night"] == null ? null : json["night"].toDouble(),
//         eve: json["eve"] == null ? null : json["eve"].toDouble(),
//         morn: json["morn"] == null ? null : json["morn"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "day": day == null ? null : day,
//         "night": night == null ? null : night,
//         "eve": eve == null ? null : eve,
//         "morn": morn == null ? null : morn,
//       };
// }

// class Temp {
//   Temp({
//     required this.day,
//     required this.min,
//     required this.max,
//     required this.night,
//     required this.eve,
//     required this.morn,
//   });

//   final double day;
//   final double min;
//   final double max;
//   final double night;
//   final double eve;
//   final double morn;

//   factory Temp.fromMap(Map<String, dynamic> json) => Temp(
//         day: json["day"] == null ? null : json["day"].toDouble(),
//         min: json["min"] == null ? null : json["min"].toDouble(),
//         max: json["max"] == null ? null : json["max"].toDouble(),
//         night: json["night"] == null ? null : json["night"].toDouble(),
//         eve: json["eve"] == null ? null : json["eve"].toDouble(),
//         morn: json["morn"] == null ? null : json["morn"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "day": day == null ? null : day,
//         "min": min == null ? null : min,
//         "max": max == null ? null : max,
//         "night": night == null ? null : night,
//         "eve": eve == null ? null : eve,
//         "morn": morn == null ? null : morn,
//       };
// }

// class Weather {
//   Weather({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });

//   final int id;
//   final String main;
//   final String description;
//   final String icon;

//   factory Weather.fromMap(Map<String, dynamic> json) => Weather(
//         id: json["id"] == null ? null : json["id"],
//         main: json["main"] == null ? null : json["main"],
//         description: json["description"] == null ? null : json["description"],
//         icon: json["icon"] == null ? null : json["icon"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id == null ? null : id,
//         "main": main == null ? null : main,
//         "description": description == null ? null : description,
//         "icon": icon == null ? null : icon,
//       };
// }
