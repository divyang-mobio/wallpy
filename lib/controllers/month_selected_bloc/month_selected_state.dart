part of 'month_selected_bloc.dart';

abstract class MonthSelectedState {}

class MonthSelectedLoading extends MonthSelectedState {}

class MonthSelectedLoaded extends MonthSelectedState {
  String selected;
  List<String> data;

  MonthSelectedLoaded({required this.data, required this.selected});
}

class MonthSelectedError extends MonthSelectedState {}
