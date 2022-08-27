part of 'admin_visible_bloc.dart';

abstract class AdminVisibleEvent {}

class CheckAdmin extends AdminVisibleEvent {}

class SetAdmin extends AdminVisibleEvent {}

class UnSetAdmin extends AdminVisibleEvent {}

