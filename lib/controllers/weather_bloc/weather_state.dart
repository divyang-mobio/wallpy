part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherApiResModel data;

  const WeatherLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class WeatherError extends WeatherState {
  final dynamic error;
  const WeatherError({required this.error});

  @override
  List<Object> get props => [error];
}
