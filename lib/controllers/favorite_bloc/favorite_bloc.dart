import 'package:bloc/bloc.dart';

import '../../models/data_model.dart';
import '../../utils/firestore_database_calling.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FirebaseDatabase _firebaseDatabase;

  FavoriteBloc(this._firebaseDatabase) : super(FavoriteLoading()) {
    on<GetFavoriteData>(_getAllData);
    on<AddFavorite>(_addFavorite);
  }
  int ads = 0;

  _addFavorite(AddFavorite event, Emitter<FavoriteState> emit) async {
    _firebaseDatabase.update(event.dataModel);
    if (event.dataModel.fav) {
      _firebaseDatabase.data.add(event.dataModel);

      /// if ads need to add in Favorite
      // ads += 1;
      // if(ads == TextResources().adsInternalInList) {
      //   _firebaseDatabase.data.add("list");
      // }
    } else {
      _firebaseDatabase.data.remove(event.dataModel);
      // ads -= 1;
    }
    emit(FavoriteLoaded(data: _firebaseDatabase.data));
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
