import 'package:flutter/material.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/screens/category_detail_screen.dart';
import 'package:wallpy/screens/main_screen.dart';
import 'package:wallpy/widgets/network_image.dart';

class CategoryListView extends StatelessWidget {
  final List<dynamic> data;

  const CategoryListView({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.14,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return CategoryDetailScreen(
                                data: data.elementAt(index)['data'],
                                title: data
                                    .elementAt(index)['name']
                                    .toString()
                                    .toUpperCase(),
                              );
                            }));
                          },
                          child: Stack(children: [
                            customCategorySection(context, ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Hero(
                                  tag: data.elementAt(index)['data'],
                                  child: networkImages(
                                      data
                                          .elementAt(index)['data']
                                          .first['image_url']
                                          .toString(),
                                      BoxFit.fitWidth)),
                            )),
                            customCategorySection(
                              context,
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    data
                                        .elementAt(index)['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: ColorResources().textColorWhite,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ])));
                })),
        const Expanded(child: MyHomePage())
      ],
    );
  }
}

Padding customCategorySection(context, Widget child) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              color: ColorResources().detailScreenContainerDark,
              borderRadius: BorderRadius.circular(20)),
          child: child));
}
