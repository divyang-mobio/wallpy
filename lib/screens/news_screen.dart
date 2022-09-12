import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/news_data_fetch_bloc/news_data_fetch_bloc.dart';
import '../resources/resources.dart';
import '../widgets/category_tile.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/news_listview.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
      BlocProvider.of<NewsDataFetchBloc>(context)
          .add(GetAllNewsData(url: TextResources().url));
      return;
    },
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: categoryData.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => CategoriesTile(
                      category: categoryData[index],
                    )),
          ),
          BlocBuilder<NewsDataFetchBloc, NewsDataFetchState>(
              builder: (context, state) {
            if (state is NewsDataFetchLoading) {
              return shimmer(context, false);
            } else if (state is NewsDataFetchLoaded) {
              return listView(state.data, false);
            } else if (state is NewsDataFetchError) {
              return Center(child: Text(TextResources().blocError));
            } else {
              return Center(child: Text(TextResources().noData));
            }
          }),
        ],
      ),
    ));
  }
}
