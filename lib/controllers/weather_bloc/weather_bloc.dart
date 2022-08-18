import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpy/models/weather_model.dart';
import 'package:wallpy/utils/http_requets.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final HttpRequests httpRequests;
  WeatherBloc(this.httpRequests) : super(WeatherLoading()) {
    on<GetAllWeather>((event, emit) async {
      try {
        WeatherApiResModel weatherData = await httpRequests.determinePosition();

        emit(WeatherLoaded(data: weatherData));
      } catch (e) {
        emit(WeatherError(error: e));
      }
    });
  }
}
