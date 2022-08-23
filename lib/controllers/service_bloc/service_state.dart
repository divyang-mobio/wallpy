part of 'service_bloc.dart';

abstract class ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  bool isOn;
  ServiceLoaded({required this.isOn});
}

class ServiceError extends ServiceState {}

