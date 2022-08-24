part of 'gradiant_bloc.dart';

abstract class GradiantEvent {}

class SelectedColor extends GradiantEvent {
  List<Color> myColor;

  SelectedColor({required this.myColor});
}
