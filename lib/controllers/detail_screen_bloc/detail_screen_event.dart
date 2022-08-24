part of 'detail_screen_bloc.dart';

abstract class DetailScreenEvent {}

class OnTab extends DetailScreenEvent{
  bool isVis;

  OnTab({required this.isVis});
}
