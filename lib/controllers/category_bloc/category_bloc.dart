import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpy/utils/firestore_database_calling.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final FirebaseDatabase _firebaseDatabase;

  CategoryBloc(this._firebaseDatabase) : super(CategoryLoading()) {
    on<GetAllCategory>((event, emit) async {
      try {
        List<dynamic> data = [];
        data.addAll(await _firebaseDatabase.getCategoryData(true));
        emit(CategoryLoaded(data: data));
      } catch (e) {
        emit(CategoryError());
      }
    });
  }
}
