part of 'service_bloc.dart';

abstract class ServiceEvent {}

class OnChange extends ServiceEvent {
  bool isOn, isFavorite;
  int screen, interval;

  OnChange(
      {required this.isOn,
      required this.screen,
      required this.interval,
      required this.isFavorite});
}

class CheckService extends ServiceEvent {
  PreferenceServices pref;

  CheckService({required this.pref});
}
