import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../resources/resources.dart';
import '../controllers/favorite_bloc/favorite_bloc.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/gridview.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<FavoriteBloc>(context)
            .add(GetFavoriteData(isFavorite: true, category: null));
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
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return shimmer(context, true);
        } else if (state is FavoriteLoaded) {
          return (state.data.isEmpty)
              ? Center(child: Text(TextResources().emptyCart))
              : gridView(state.data, _scrollController, false);
        } else if (state is FavoriteError) {
          return Center(child: Text(TextResources().blocError));
        } else {
          return const Center(child: Text("Error No Data :("));
        }
      },
    );
  }
}
