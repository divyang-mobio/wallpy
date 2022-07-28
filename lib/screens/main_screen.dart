import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpy/models/data_model.dart';
import '../controllers/data_fetch_bloc.dart';
import '../resources/resources.dart';
import '../widgets/gridview.dart';

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
        print("scroll");
        BlocProvider.of<DataFetchBloc>(context).add(GetAllData());
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
    return Scaffold(
      backgroundColor: ColorResources().background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResources().appBar,
        centerTitle: true,
        title: Text(
          TextResources().appTitle,
          style: TextStyle(color: ColorResources().appBarTextIcon),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(IconsResources().search,
                  color: ColorResources().appBarTextIcon))
        ],
      ),
      body: BlocBuilder<DataFetchBloc, DataFetchState>(
        builder: (context, state) {
          if (state is DataFetchLoading) {
            return Shimmer.fromColors(
                baseColor: ColorResources().shimmerBase,
                highlightColor: ColorResources().shimmerHighlight,
                child: gridView([] , null , true));
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is DataFetchLoaded) {
            return gridView(state.data, _scrollController , false);
          } else if (state is DataFetchError) {
            return const Center(child: Text("Error :("));
          } else {
            return const Center(child: Text("Error No Data :("));
          }
        },
      ),
      // Column(
      //   children: [
      //     Container(
      //       height: 80,
      //       child: ListView.builder(
      //           shrinkWrap: true,
      //           scrollDirection: Axis.horizontal,
      //           itemCount: categoryData.length,
      //           itemBuilder: (context, index) => Container(
      //                 margin: const EdgeInsets.all(5),
      //                 decoration: BoxDecoration(
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(20)),
      //                     color: ColorResources().categoryContainer,
      //                     border: Border.all(
      //                         color:
      //                             ColorResources().categoryContainerBorder)),
      //                 child: TextButton(
      //                   onPressed: () {},
      //                   child: Text(categoryData[index].name,
      //                       style: Theme.of(context).textTheme.subtitle1),
      //                 ),
      //               )),
      //     ),
      //     const SizedBox(height: 10),
      //     Container(
      //       child: BlocBuilder<DataFetchBloc, DataFetchState>(
      //         builder: (context, state) {
      //           if (state is DataFetchLoading) {
      //             return const Center(child: CircularProgressIndicator.adaptive());
      //           } else if (state is DataFetchLoaded) {
      //             return gridView(state.data);
      //           } else if (state is DataFetchError) {
      //             return const Center(child: Text("Error :("));
      //           } else {
      //             return const Center(child: Text("Error No Data :("));
      //           }
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: Row(
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         BlocProvider.of<DataFetchBloc>(context)
      //             .add(GetCategoryAllData(category: "nature"));
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         BlocProvider.of<DataFetchBloc>(context)
      //             .add(GetCategoryAllData(category: "city"));
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         BlocProvider.of<DataFetchBloc>(context)
      //             .add(GetCategoryAllData(category: "flower"));
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         BlocProvider.of<DataFetchBloc>(context)
      //             .add(GetCategoryAllData(category: "movie"));
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         BlocProvider.of<DataFetchBloc>(context)
      //             .add(GetCategoryAllData(category: "outside"));
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
    );
  }
}
