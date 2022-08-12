import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/search_bloc.dart';
import '../resources/resources.dart';
import '../utils/firestore_database_calling.dart';
import '../widgets/gridview.dart';
import '../widgets/shimmer_loading.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.screen}) : super(key: key);
  final int screen;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print("scroll");
        callBloc(context, textEditingController.text, widget.screen, false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorResources().appBar,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              IconsResources().back,
              color: ColorResources().appBarTextIcon,
            )),
        title: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: TextResources().searchHint,
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (s) => callBloc(
              context, textEditingController.text, widget.screen, true),
        ),
        elevation: 6.0,
        actions: [
          IconButton(
              onPressed: () => callBloc(
                  context, textEditingController.text, widget.screen, true),
              icon: Icon(IconsResources().search,
                  size: 35, color: ColorResources().search))
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchLoading) {
          return shimmer(true);
        } else if (state is SearchLoaded) {
          return (state.data.isEmpty)
              ? Center(child: Text(TextResources().onSearchNoDataFound))
              : gridView(state.data, _scrollController, false);
        } else if (state is SearchError) {
          return Center(child: Text(TextResources().blocError));
        } else {
          return const Center(child: Text("Error No Data :("));
        }
      }),
    );
  }
}

void callBloc(context, String query, int screen, bool isSearch) {
  BlocProvider.of<SearchBloc>(context).add(SearchData(
      firebaseDatabase: FirebaseDatabase(),
      query: query,
      isFavorite: (screen == 2) ? true : false,
      isSearch: true));
}
