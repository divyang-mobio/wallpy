import 'package:flutter/material.dart';
import '../models/data_model.dart';
import '../resources/resources.dart';
import 'network_image.dart';
import '../models/navigation_model.dart';

GestureDetector gridCard(
    BuildContext context, DataModel dataModel, bool isLoading) {
  return GestureDetector(
    onTap: () => isLoading
        ? {}
        : Navigator.pushNamed(
            context,
            TextResources().detailScreenRoute,
            arguments: DetailScreenArgument(dataModel: dataModel),
          ),
    child: Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: isLoading
          ? null
          : Hero(tag: dataModel.name, child: networkImages(dataModel.url, null)),
    ),
  );
}
