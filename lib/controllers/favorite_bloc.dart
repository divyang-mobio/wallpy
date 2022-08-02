import 'package:bloc/bloc.dart';
import '../models/data_model.dart';
import '../utils/firestore_database_calling.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FirebaseDatabase _firebaseDatabase;

  FavoriteBloc(this._firebaseDatabase) : super(FavoriteLoading()) {
    on<GetFavoriteData>(_getAllData);
    on<AddFavorite>(_addFavorite);
  }

  void _addFavorite(AddFavorite event, Emitter<FavoriteState> emit) {
    _firebaseDatabase.update(event.dataModel);
  }

  void _getAllData(GetFavoriteData event, Emitter<FavoriteState> emit) async {
    try {
      emit(await _getData(event.category, event.isFavorite));
    } catch (e) {
      emit(FavoriteError());
    }
  }

  Future<FavoriteLoaded> _getData(String? category, bool isFavorite) async =>
      FavoriteLoaded(
          data: await _firebaseDatabase.getAllData(category, isFavorite));
}
