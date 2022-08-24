import 'package:bloc/bloc.dart';

part 'detail_screen_event.dart';
part 'detail_screen_state.dart';

class DetailScreenBloc extends Bloc<DetailScreenEvent, DetailScreenState> {
  DetailScreenBloc() : super(DetailScreenLoading()) {
    on<OnTab>((event, emit) {
      emit(DetailScreenLoaded(isVis: event.isVis));
    });
  }
}
