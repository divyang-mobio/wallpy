part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetAllWeather extends WeatherEvent {
  final WeatherApiResModel? weather;

  const GetAllWeather({
    this.weather,
  });
}
