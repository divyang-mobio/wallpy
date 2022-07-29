import 'package:flutter/material.dart';
import '../models/data_model.dart';
import 'grid_card.dart';

GridView gridView(
    List<DataModel> data, ScrollController? controller, bool isLoading) {
  return GridView.builder(
    controller: controller,
    shrinkWrap: true,
    itemCount: isLoading ? 10 : data.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 4 / 6.5,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        crossAxisCount: 2),
    itemBuilder: (context, index) => gridCard(
        context,
        (isLoading)
            ? DataModel(
                id: 0,
                name: "loading",
                uid: "loading",
                category: "loading",
                fav: false,
                timestamp: DateTime.now(),
                url: "loading")
            : data[index],
        isLoading),
  );
}
