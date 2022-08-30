import 'package:flutter/material.dart';
import '../models/data_model.dart';
import '../resources/resources.dart';
import 'grid_card.dart';

Padding gridView(
    List<Object> data, ScrollController? controller, bool isLoading) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: GridView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: isLoading ? 10 : data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9 / 16,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        Object? item = isLoading ? loadingDataModel : data[index];
        return (item is DataModel)
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: gridCard(context, item, isLoading))
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: ColorResources().textColorBlack),
              );
      },
    ),
  );
}
