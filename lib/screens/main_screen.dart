import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/firestore_database_calling.dart';
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
        snackBar((RepositoryProvider.of<FirebaseDatabase>(context).isMore)
            ? TextResources().snackBarLoadingInPagination
            : TextResources().snackBarAllDataFetchInPagination);
      }
    });
  }

  void snackBar(String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
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
            return Shimmer.fromColors(
                baseColor: ColorResources().shimmerBase,
                highlightColor: ColorResources().shimmerHighlight,
                child: gridView([], null, true));
          } else if (state is DataFetchLoaded) {
            return gridView(state.data, _scrollController, false);
          } else if (state is DataFetchError) {
            return const Center(child: Text("Error :("));
          } else {
            return const Center(child: Text("Error No Data :("));
          }
        },
      );
      // floatingActionButton: Row(
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () async {
      //         await AndroidAlarmManager.periodic(const Duration(minutes: 1),
      //             TextResources().androidAlarmManagerId, callWallpaperSetter);
      //         // BackgroundService().startService();
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         AndroidAlarmManager.cancel(TextResources().androidAlarmManagerId);
      //         // BackgroundService().stopService();
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
  }
}
