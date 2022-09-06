part of 'month_selected_bloc.dart';

abstract class MonthSelectedEvent {}

class IsOccasion extends MonthSelectedEvent {}

class RemoveOccasion extends MonthSelectedEvent {}

class OnSelectMonth extends MonthSelectedEvent {
  String month;

  OnSelectMonth({required this.month});
}
