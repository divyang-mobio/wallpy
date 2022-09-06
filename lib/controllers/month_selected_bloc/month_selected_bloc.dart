import 'package:bloc/bloc.dart';

part 'month_selected_event.dart';

part 'month_selected_state.dart';

class MonthSelectedBloc extends Bloc<MonthSelectedEvent, MonthSelectedState> {
  List<String> months;

  MonthSelectedBloc(this.months) : super(MonthSelectedLoading()) {
    on<IsOccasion>((event, emit) {
      emit(MonthSelectedLoaded(data: months, selected: months[0]));
    });
    on<RemoveOccasion>((event, emit) {
      emit(MonthSelectedLoading());
    });
    on<OnSelectMonth>((event, emit) {
      emit(MonthSelectedLoaded(data: months, selected: event.month));
    });
  }
}
