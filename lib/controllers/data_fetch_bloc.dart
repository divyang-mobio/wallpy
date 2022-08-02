import 'package:bloc/bloc.dart';
import '../models/data_model.dart';
import '../utils/firestore_database_calling.dart';

part 'data_fetch_event.dart';

part 'data_fetch_state.dart';

class DataFetchBloc extends Bloc<DataFetchEvent, DataFetchState> {
  final FirebaseDatabase _firebaseDatabase;

  DataFetchBloc(this._firebaseDatabase) : super(DataFetchLoading()) {
    on<GetAllData>(_getAllData);
  }

  void _getAllData(GetAllData event, Emitter<DataFetchState> emit) async {
    try {
      emit(await _getData(event.category, event.isFavorite));
    } catch (e) {
      emit(DataFetchError());
    }
  }

  Future<DataFetchLoaded> _getData(
          String? category, bool isFavorite) async =>
      DataFetchLoaded(
          data: await _firebaseDatabase.getAllData(
              category, isFavorite));
}
