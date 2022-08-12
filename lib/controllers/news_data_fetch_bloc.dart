import 'package:bloc/bloc.dart';
import '../models/articles_model.dart';
import '../utils/news_api_calling.dart';

part 'news_data_fetch_event.dart';

part 'news_data_fetch_state.dart';

class NewsDataFetchBloc extends Bloc<NewsDataFetchEvent, NewsDataFetchState> {
  HttpService httpService;

  NewsDataFetchBloc(this.httpService) : super(NewsDataFetchLoading()) {
    on<GetAllNewsData>(_getAllNewsData);
  }

  _getAllNewsData(
      GetAllNewsData event, Emitter<NewsDataFetchState> emit) async {
    try {
      emit(NewsDataFetchLoaded(data: await httpService.getData(event.url)));
    } catch (e) {
      emit(NewsDataFetchError(error: e.toString()));
    }
  }
}
