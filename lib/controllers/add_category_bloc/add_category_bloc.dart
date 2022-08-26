import 'package:bloc/bloc.dart';

part 'add_category_event.dart';

part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  AddCategoryBloc() : super(AddCategoryInitial()) {
    on<AddCategory>((event, emit) {
      emit(AddCategoryLoaded(myCategory: event.myCategory));
    });
  }
}
