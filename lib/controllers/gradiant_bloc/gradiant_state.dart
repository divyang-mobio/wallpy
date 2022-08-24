part of 'gradiant_bloc.dart';

abstract class GradiantState {}

class GradiantInitial extends GradiantState {}

class GradiantLoaded extends GradiantState {
  List<Color> myColor;

  GradiantLoaded({required this.myColor});
}
