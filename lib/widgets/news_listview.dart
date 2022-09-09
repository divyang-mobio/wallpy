import 'package:flutter/material.dart';
import '../models/navigation_model.dart';
import '../resources/resources.dart';
import '../models/articles_model.dart';
import 'network_image.dart';

ListView listView(List<Articles> data, bool isLoading) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isLoading ? 20 : data.length,
      itemBuilder: (context, index) => isLoading
          ? const Card(child: SizedBox(height: 90))
          : cardView(context, data[index]));
}

cardView(context, Articles data) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
        context, TextResources().detailNewsScreenRoute,
        arguments: DetailNewsScreenArgument(articles: data)),
    child: Card(
      elevation: 8,
      child: Row(
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: networkImages(data.urlToImage.toString(), null)),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(data.publishedAt.toString(),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(data.description.toString(),
                    maxLines: 2, overflow: TextOverflow.ellipsis)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
