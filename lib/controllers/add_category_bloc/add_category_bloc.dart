import 'package:bloc/bloc.dart';

import '../../utils/firestore_database_calling.dart';

part 'add_category_event.dart';

part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase();
  List<String> data = [];

  AddCategoryBloc() : super(AddCategoryInitial()) {
    on<ShowCategory>((event, emit) async {
      data.addAll(await _firebaseDatabase.getCategoryData(false));
      emit(AddCategoryLoaded(data: data, select: data[1]));
    });
    on<OnSelectCategory>((event, emit) async {
      data.sort();
      emit(AddCategoryLoaded(data: data, select: event.myCategory));
    });
    on<OnSubmitCategory>((event, emit) async {
      if (!data.contains(event.data)) {
        data.add(event.data);
      }
      emit(AddCategoryLoaded(data: data, select: data[1]));
    });
  }
}
