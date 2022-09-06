import 'package:bloc/bloc.dart';

import '../../utils/firestore_database_calling.dart';

part 'data_fetch_event.dart';

part 'data_fetch_state.dart';

class DataFetchBloc extends Bloc<DataFetchEvent, DataFetchState> {
  final FirebaseDatabase _firebaseDatabase;

  DataFetchBloc(this._firebaseDatabase) : super(DataFetchLoading()) {
    on<GetAllData>(_getAllData);
    on<OnRefresh>(_onReFresh);
  }

  Future<void> _onReFresh(OnRefresh event, Emitter<DataFetchState> emit) async {
    emit(DataFetchLoading());
      List<Object> data = [];
      data.addAll(await _firebaseDatabase.getAllData(
          null, false, null, event.isRefresh, true));
      emit(DataFetchLoaded(data: data));
  }

  void _getAllData(GetAllData event, Emitter<DataFetchState> emit) async {
      List<Object> data = [];
      data.addAll(await _firebaseDatabase.getAllData(
          event.category, event.isFavorite, null, false, true));
      emit(DataFetchLoaded(data: data));
  }
}