part of 'admin_visible_bloc.dart';

abstract class AdminVisibleState {}

class AdminVisibleLoading extends AdminVisibleState {}

class AdminVisibleTrue extends AdminVisibleState {}

class AdminVisibleFalse extends AdminVisibleState {}

class AdminVisibleError extends AdminVisibleState {}
