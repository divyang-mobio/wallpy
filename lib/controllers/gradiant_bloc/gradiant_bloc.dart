import 'dart:ui';

import 'package:bloc/bloc.dart';

part 'gradiant_event.dart';

part 'gradiant_state.dart';

class GradiantBloc extends Bloc<GradiantEvent, GradiantState> {
  GradiantBloc() : super(GradiantInitial()) {
    on<SelectedColor>((event, emit) async {
      emit(GradiantInitial());
      await Future.delayed(const Duration(seconds: 1));
      emit(GradiantLoaded(myColor: event.myColor));
    });
  }
}
