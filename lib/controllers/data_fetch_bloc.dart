import 'package:bloc/bloc.dart';
import '../models/data_model.dart';
import '../utils/firestore_database_calling.dart';

part 'data_fetch_event.dart';

part 'data_fetch_state.dart';

class DataFetchBloc extends Bloc<DataFetchEvent, DataFetchState> {
  final FirebaseDatabase _firebaseDatabase;

  DataFetchBloc(this._firebaseDatabase) : super(DataFetchLoading()) {
    on<GetAllData>(_getAllData);
    on<GetCategoryAllData>(_getCategoryData);
  }

  void _getAllData(GetAllData event, Emitter<DataFetchState> emit) async {
    try {
      emit(await _getData(null));
    } catch (e) {
      emit(DataFetchError());
    }
  }

  void _getCategoryData(
      GetCategoryAllData event, Emitter<DataFetchState> emit) async {
    try {
      emit(await _getData(event.category));
    } catch (e) {
      emit(DataFetchError());
    }
  }

  Future<DataFetchLoaded> _getData(String? category) async =>
      DataFetchLoaded(data: await _firebaseDatabase.getAllData(category));
}
