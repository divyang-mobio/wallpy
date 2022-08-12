import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/news_data_fetch_bloc.dart';
import 'package:wallpy/widgets/shimmer_loading.dart';

import '../widgets/news_listview.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDataFetchBloc, NewsDataFetchState>(
        builder: (context, state) {
      if (state is NewsDataFetchLoading) {
        return shimmer(false);
      } else if (state is NewsDataFetchLoaded) {
        return listView(state.data , false);
      } else if (state is NewsDataFetchError) {
        return const Center(child: Text("state error"));
      } else {
        return const Center(child: Text("error"));
      }
    });
  }
}
