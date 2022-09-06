import 'package:flutter/material.dart';
import 'package:wallpy/widgets/network_image.dart';
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
      child: Stack(
        children: [
          categoryContainerForNews(ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: networkImages(category.imageLink, BoxFit.fitWidth))),
          categoryContainerForNews(Align(
            alignment: Alignment.center,
            child: Text(category.title,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorResources().textColorWhite)),
          )),
        ],
      ),
    );
  }
}

Container categoryContainerForNews(Widget child) {
  return Container(
      margin: const EdgeInsets.only(top: 20, right: 10, bottom: 20, left: 5),
      decoration: BoxDecoration(
          color: ColorResources().newsScreenTextCategoryContainer,
          borderRadius: BorderRadius.circular(15)),
      width: 120,
      height: 80,
      child: child);
}
