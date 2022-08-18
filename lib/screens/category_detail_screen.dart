import 'package:flutter/material.dart';
import 'package:wallpy/models/data_model.dart';
import 'package:wallpy/models/navigation_model.dart';
import 'package:wallpy/resources/resources.dart';

import 'package:wallpy/widgets/network_image.dart';

class CategoryDetailScreen extends StatefulWidget {
  final List<Map> data;
  final String title;

  const CategoryDetailScreen(
      {Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorResources().appBarTextIcon),
        backgroundColor: ColorResources().appBar,
        title: Text(widget.title, style: Theme.of(context).textTheme.headline1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: GridView.builder(
          controller: controller,
          shrinkWrap: true,
          itemCount: widget.data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 4 / 6.5,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            String item = widget.data[index]['image_url'].toString();
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                onTap: () {
                  DataModel data = DataModel.fromJson(
                      widget.data[index] as Map<String, dynamic>);
                  Navigator.pushNamed(
                    context,
                    TextResources().detailScreenRoute,
                    arguments: DetailScreenArgument(dataModel: data),
                  );
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Hero(tag: item, child: networkImages(item)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
