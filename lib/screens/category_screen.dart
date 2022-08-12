import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/category_bloc/category_bloc.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/screens/category_detail_screen.dart';
import 'package:wallpy/widgets/categoryListView.dart';
import 'package:wallpy/widgets/network_image.dart';
import 'package:wallpy/widgets/shimmer_loading.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return categoryshimmer(context);
      } else if (state is CategoryLoaded) {
        return CategoryListView(
          data: state.data,
        );
        //gridView(state.data, _scrollController, false);
      } else if (state is CategoryError) {
        return Center(child: Text(TextResources().blocError));
      } else {
        return const Center(child: Text("Error No Data :("));
      }
    });
  }
}
