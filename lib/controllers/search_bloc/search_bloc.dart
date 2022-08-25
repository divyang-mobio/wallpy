// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import '../../utils/firestore_database_calling.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  FirebaseDatabase firebase;
  SearchBloc(this.firebase) : super(SearchLoading()) {
    on<SearchData>(_searchData);
    on<CleanData>((event, emit) {
      emit(SearchLoading());
      firebase.data.clear();
    });
  }

  _searchData(SearchData event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoaded(
          data: await firebase.getAllData(
              null, event.isFavorite, event.query, event.isSearch, false)));
    } catch (e) {
      emit(SearchError());
    }
  }
}
