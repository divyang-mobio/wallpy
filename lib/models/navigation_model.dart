import 'articles_model.dart';
import 'data_model.dart';

class DetailScreenArgument {
  DataModel dataModel;

  DetailScreenArgument({required this.dataModel});
}

class SearchScreenArgument {
  int selectedScreen;

  SearchScreenArgument({required this.selectedScreen});
}

class DetailNewsScreenArgument {
  Articles articles;

  DetailNewsScreenArgument({required this.articles});
}
