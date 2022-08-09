import 'package:bloc/bloc.dart';

import '../../utils/firestore_database_calling.dart';

part 'data_fetch_event.dart';

part 'data_fetch_state.dart';

class DataFetchBloc extends Bloc<DataFetchEvent, DataFetchState> {
  final FirebaseDatabase _firebaseDatabase;

  DataFetchBloc(this._firebaseDatabase) : super(DataFetchLoading()) {
    on<GetAllData>(_getAllData);
  }

  void _getAllData(GetAllData event, Emitter<DataFetchState> emit) async {
    try {
      List<Object> data = [];
      data.addAll(
          await _firebaseDatabase.getAllData(event.category, event.isFavorite));
      emit(DataFetchLoaded(data: data));
    } catch (e) {
      emit(DataFetchError());
    }
  }
}
