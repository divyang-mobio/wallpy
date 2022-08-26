import 'package:flutter/material.dart';
import 'package:wallpy/resources/extension/text_extension.dart';
import 'package:wallpy/screens/category_detail_screen.dart';

class OccasionDetailScreen extends StatelessWidget {
  final List<Map> data;
  String title;
  OccasionDetailScreen({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<String> monthName =
        data.map((element) => element['month'].toString()).toSet();

    return Scaffold(
        appBar: AppBar(
          title: Text(title.firstCaps()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: monthName.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                monthName
                                    .elementAt(index)
                                    .toString()
                                    .firstCaps(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Builder(builder: (context) {
                              var selectMonthList = data.where((element) =>
                                  element['month']
                                      .toString()
                                      .toLowerCase()
                                      .contains(monthName
                                          .elementAt(index)
                                          .toLowerCase()));

                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, monthindex) {
                                    final Map<dynamic, dynamic> month =
                                        selectMonthList.elementAt(monthindex);
                                    return monthindex == 2
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                                image:
                                                    month['image_url'] == null
                                                        ? null
                                                        : DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                              month['image_url']
                                                                  .toString(),
                                                            )),
                                                //   color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: Text(
                                                'More',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (ctx) {
                                                    return CategoryDetailScreen(
                                                      data: selectMonthList
                                                          .toList(),
                                                      title: monthName
                                                          .elementAt(index)
                                                          .toString()
                                                          .firstCaps(),
                                                    );
                                                  }));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Hero(
                                                      tag: 1,
                                                      child: Image.network(
                                                        month['image_url']
                                                            .toString(),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                )));
                                  });
                            }),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
