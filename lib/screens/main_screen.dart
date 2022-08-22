import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/data_fetch_bloc/data_fetch_bloc.dart';
import '../resources/resources.dart';
import '../widgets/gridview.dart';
import '../widgets/shimmer_loading.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<DataFetchBloc>(context)
            .add(GetAllData(isFavorite: false, category: null));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataFetchBloc, DataFetchState>(
      builder: (context, state) {
        if (state is DataFetchLoading) {
          return shimmer(context, true);
        } else if (state is DataFetchLoaded) {
          return gridView(state.data, _scrollController, false);
        } else if (state is DataFetchError) {
          return Center(child: Text(TextResources().blocError));
        } else {
          return Center(child: Text(TextResources().noData));
        }
      },
    );
  }
}
