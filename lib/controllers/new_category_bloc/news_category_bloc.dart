import 'package:bloc/bloc.dart';
import '../../utils/news_api_calling.dart';
import '../../models/articles_model.dart';

part 'news_category_event.dart';
part 'news_category_state.dart';

class NewsCategoryBloc extends Bloc<NewsCategoryEvent, NewsCategoryState> {
  final HttpService httpService = HttpService();
  NewsCategoryBloc() : super(NewsCategoryLoading()) {
    on<GetAllNewsCategoryData>(_getAllNewsCategoryData);
  }

  _getAllNewsCategoryData(GetAllNewsCategoryData event, Emitter<NewsCategoryState> emit) async {
    emit(NewsCategoryLoaded(data: await httpService.getData(event.url)));
  }
}
