import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/new_category_bloc/news_category_bloc.dart';
import '../models/news_category_model.dart';
import '../resources/resources.dart';
import '../widgets/news_listview.dart';
import '../widgets/shimmer_loading.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({Key? key, required this.category})
      : super(key: key);
  final NewsCategory category;

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreenState();
}

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCategoryBloc>(context)
        .add(GetAllNewsCategoryData(url: widget.category.link));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.category.title} ${TextResources().categoryTitleNews}"),
      ),
      body: BlocBuilder<NewsCategoryBloc, NewsCategoryState>(
          builder: (context, state) {
        if (state is NewsCategoryLoading) {
          return shimmer(context, false);
        } else if (state is NewsCategoryLoaded) {
          return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<NewsCategoryBloc>(context)
                    .add(GetAllNewsCategoryData(url: widget.category.link));
                return;
              },
              child: listView(state.data, false));
        } else if (state is NewsCategoryError) {
          return Center(child: Text(TextResources().blocError));
        } else {
          return Center(child: Text(TextResources().noData));
        }
      }),
    );
  }
}
