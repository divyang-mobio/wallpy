import 'package:flutter/material.dart';
import 'grid_card.dart';

GridView gridView() {
  return GridView.builder(
    itemCount: 10,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 4 / 6.5,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        crossAxisCount: 2),
    itemBuilder: (context, index) => gridCard(context),
  );
}
