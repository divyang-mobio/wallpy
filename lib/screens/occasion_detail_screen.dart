import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallpy/resources/extension/text_extension.dart';
import 'package:wallpy/screens/category_detail_screen.dart';
import 'package:wallpy/widgets/shimmer_loading.dart';

class OccasionDetailScreen extends StatelessWidget {
  final List<Map> data;
  String title;
  OccasionDetailScreen({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String month = DateFormat('MMMM').format(DateTime.now());
    print('month=== ${month}');

    List<String> _monthName =
        data.map((element) => element['month'].toString()).toSet().toList();

    List<String> monthName = [];

    for (int i = 0; i < _monthName.length; i++) {
      if (i ==
          _monthName.indexOf(
              _monthName.firstWhere((element) => element.contains(month)))) {
        print(_monthName.elementAt(i));
        monthName.add(_monthName.elementAt(i));
      }

      if (i >
          _monthName.indexOf(
              _monthName.firstWhere((element) => element.contains(month)))) {
        monthName.add(_monthName.elementAt(i));
      }
    }
    for (int i = 0; i < _monthName.length; i++) {
      if (i <
          _monthName.indexOf(
              _monthName.firstWhere((element) => element.contains(month)))) {
        monthName.add(_monthName.elementAt(i));
      }
    }

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
                    shrinkWrap: false,
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

                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return CategoryDetailScreen(
                                      data: selectMonthList.toList(),
                                      title: monthName
                                          .elementAt(index)
                                          .toString()
                                          .firstCaps(),
                                    );
                                  }));
                                },
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, monthindex) {
                                      final Map<dynamic, dynamic> month =
                                          selectMonthList.elementAt(monthindex);
                                      return month.length > 2 && monthindex == 2
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              decoration: BoxDecoration(
                                                  image: month['image_url'] ==
                                                          null
                                                      ? null
                                                      : DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            month['image_url']
                                                                .toString(),
                                                          )),
                                                  //   color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Hero(
                                                    tag: month,
                                                    child: Image.network(
                                                      month['image_url']
                                                          .toString(),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    }),
                              );
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
