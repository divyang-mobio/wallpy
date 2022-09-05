import 'package:bloc/bloc.dart';

part 'add_other_category_event.dart';
part 'add_other_category_state.dart';

class AddOtherCategoryBloc extends Bloc<AddOtherCategoryEvent, AddOtherCategoryState> {
  AddOtherCategoryBloc() : super(AddOtherCategoryInitial()) {
    on<AddNewCategory>((event, emit) {
      emit(AddOtherCategoryData(data: event.data));
    });
    on<ShowTextField>((event, emit) {
      emit(AddOtherCategoryShowTextField());
    });
    on<RemoveCategory>((event, emit) {
      emit(AddOtherCategoryShowTextField());
    });
    on<RemoveCategoryField>((event, emit) {
      emit(AddOtherCategoryInitial());
    });
    on<SubmitNewCategory>((event, emit) {
      emit(AddOtherCategoryInitial());
    });
  }
}
