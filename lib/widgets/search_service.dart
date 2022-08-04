import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/firestore_database_calling.dart';
import '../controllers/search_bloc.dart';
import 'shimmer_loading.dart';
import '../resources/resources.dart';
import 'gridview.dart';

class CustomSearchDelegate extends SearchDelegate {
  final ScrollController _scrollController;
  int screen;

  CustomSearchDelegate(this._scrollController, this.screen);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(IconsResources().searchClear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(IconsResources().searchBack),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    callingFireStore(context, 'resultsDebounce');
    return buildData();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    callingFireStore(context, 'suggestionDebounce');
    return buildData();
  }

  void callingFireStore(context , String id){
    EasyDebounce.debounce(
        id,
        const Duration(milliseconds: 500),
            () =>
            BlocProvider.of<SearchBloc>(context).add(SearchData(
              firebaseDatabase: FirebaseDatabase(),
                query: query,
                isFavorite: (screen == 2) ? true : false,
                isSearch: true)));
  }

  buildData() {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchLoading) {
        return shimmer();
      } else if (state is SearchLoaded) {
        return (state.data.isEmpty)
            ? const Center(child: Text("no data"))
            : gridView(state.data, _scrollController, false);
      } else if (state is SearchError) {
        return Center(child: Text(TextResources().blocError));
      } else {
        return const Center(child: Text("Error No Data :("));
      }
    });
  }
}
