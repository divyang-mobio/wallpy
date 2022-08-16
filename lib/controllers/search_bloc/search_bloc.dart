import 'package:bloc/bloc.dart';
import '../../utils/firestore_database_calling.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading()) {
    on<SearchData>(_searchData);
  }

  _searchData(SearchData event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoaded(
          data: await event.firebaseDatabase.getAllData(
              null, event.isFavorite, event.query, event.isSearch, false)));
    } catch (e) {
      print("error");
    }
  }
}
