import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../controllers/search_bloc/search_bloc.dart';
import '../resources/resources.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<SearchBloc>(context).add(CleanData());
            },
            icon: Icon(IconsResources().back)),
        title: TextField(
            cursorColor: BlocProvider.of<DarkModeBloc>(context).isDark
                ? ColorResources().focusedBorderTextFieldDark
                : ColorResources().focusedBorderTextField,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: TextResources().searchHint,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: BlocProvider.of<DarkModeBloc>(context).isDark
                        ? ColorResources().focusedBorderTextFieldDark
                        : ColorResources().focusedBorderTextField),
              ),
            ),
            keyboardType: TextInputType.text,
            onSubmitted: (s) => callBloc(
                context, textEditingController.text, widget.screen, true)),
        actions: [
          IconButton(
              onPressed: () => callBloc(
                  context, textEditingController.text, widget.screen, true),
              icon: Icon(IconsResources().search))
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchLoading) {
          return shimmer(context, true);
        } else if (state is SearchLoaded) {
          return (state.data.isEmpty)
              ? Center(child: Text(TextResources().onSearchNoDataFound))
              : gridView(state.data, _scrollController, false);
        } else if (state is SearchError) {
          return Center(child: Text(TextResources().blocError));
        } else {
          return Center(child: Text(TextResources().noData));
        }
      }),
    );
  }
}

void callBloc(context, String query, int screen, bool isSearch) {
  BlocProvider.of<SearchBloc>(context).add(SearchData(
      query: query, isFavorite: (screen == 2) ? true : false, isSearch: true));
}
