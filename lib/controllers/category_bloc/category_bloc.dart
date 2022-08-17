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
        data.addAll(await _firebaseDatabase.getCategoryData(event.category));
        emit(CategoryLoaded(data: data));
      } catch (e) {
        emit(CategoryError());
      }
    });
  }
}




// class DataFetchBloc extends Bloc<DataFetchEvent, DataFetchState> {
//   final FirebaseDatabase _firebaseDatabase;

//   DataFetchBloc(this._firebaseDatabase) : super(DataFetchLoading()) {
//     on<GetAllData>(_getAllData);
//   }

//   void _getAllData(GetAllData event, Emitter<DataFetchState> emit) async {
//     try {
//       List<Object> data = [];
//       data.addAll(await _firebaseDatabase.getAllData(
//           event.category, event.isFavorite, null, false, true));
//       emit(DataFetchLoaded(data: data));
//     } catch (e) {
//       emit(DataFetchError());
//     }
//   }
//}
