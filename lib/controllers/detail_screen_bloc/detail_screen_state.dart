part of 'detail_screen_bloc.dart';

abstract class DetailScreenState {}

class DetailScreenLoading extends DetailScreenState {}

class DetailScreenLoaded extends DetailScreenState {
  bool isVis;

  DetailScreenLoaded({required this.isVis});
}
