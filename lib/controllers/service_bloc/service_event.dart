part of 'service_bloc.dart';

abstract class ServiceEvent {}

class OnChange extends ServiceEvent {
  bool isOn;
  int screen, interval;

  OnChange({required this.isOn, required this.screen, required this.interval});
}

class CheckService extends ServiceEvent{
  PreferenceServices pref;

  CheckService({required this.pref});
}