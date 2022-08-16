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
