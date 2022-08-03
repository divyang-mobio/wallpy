import 'package:flutter/material.dart';
import '../models/data_model.dart';
import '../resources/resources.dart';
import 'grid_card.dart';

Padding gridView(
    List<Object> data, ScrollController? controller, bool isLoading) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: isLoading ? 10 : data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4 / 6.5,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        Object? item = isLoading ? loadingDataModel : data[index];
        return (item is DataModel)
            ? gridCard(context, item, isLoading)
            : const Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Colors.black);
      },
    ),
  );
}

void snackBar(String data, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
}
