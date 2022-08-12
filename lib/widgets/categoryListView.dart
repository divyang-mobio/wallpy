import 'package:flutter/material.dart';

import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/screens/category_detail_screen.dart';
import 'package:wallpy/widgets/network_image.dart';

class CategoryListView extends StatelessWidget {
  final List<dynamic> data;

  const CategoryListView({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return CategoryDetailScreen(
                          data: data.elementAt(index)['data']);
                    }));
                  },
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Hero(
                            tag: data
                                .elementAt(index)['data']
                                .first['image_url']
                                .toString(),
                            child: networkImages(data
                                .elementAt(index)['data']
                                .first['image_url']
                                .toString())),
                      ),
                    ),
                    Positioned(
                        top: 30,
                        right: 20,
                        child: Text(
                          data
                              .elementAt(index)['name']
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                              color: ColorResources().textColorwhite,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                        top: 70,
                        right: 20,
                        child: Text(
                          "Photos ${data.elementAt(index)['data'].length}",
                          style: TextStyle(
                            color: ColorResources().textColorwhite,
                            fontSize: 20,
                          ),
                        ))
                  ])));
        }));
  }
}
