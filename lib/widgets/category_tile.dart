import 'package:flutter/material.dart';
import '../models/news_category_model.dart';
import '../resources/resources.dart';

class CategoriesTile extends StatelessWidget {
  final NewsCategory category;

  const CategoriesTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, TextResources().newsCategoryScreenRoute,
          arguments: category),
      child: Container(
          margin:
              const EdgeInsets.only(top: 20, right: 10, bottom: 20, left: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)),
          width: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              category.title,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
