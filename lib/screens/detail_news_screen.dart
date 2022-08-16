import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/network_image.dart';
import '../resources/resources.dart';
import '../models/articles_model.dart';

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({Key? key, required this.articles}) : super(key: key);
  final Articles articles;

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorResources().appBar,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              IconsResources().back,
              color: ColorResources().appBarTextIcon,
            )),
        title: Text(TextResources().newsDetailAppTitle,
            style: Theme.of(context).textTheme.headline1),
        actions: [
          IconButton(
              onPressed: () async {
                Uri url = Uri.parse(widget.articles.url.toString());
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(TextResources().urlNotLoading)));
                }
              },
              icon: Icon(
                IconsResources().openUrl,
                color: ColorResources().appBarTextIcon,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: networkImages(widget.articles.urlToImage.toString())),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(widget.articles.publishedAt.toString()),
                      const Expanded(child: SizedBox()),
                      Text(widget.articles.author.toString(),
                          overflow: TextOverflow.clip),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(widget.articles.title.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: ColorResources().newsDetailText)),
                  const SizedBox(height: 20),
                  Text(widget.articles.description.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: ColorResources().newsDetailText)),
                  const SizedBox(height: 20),
                  Text(widget.articles.content.toString()),
                  const SizedBox(height: 20),
                  Text("Source:- ${(widget.articles.source?.name).toString()}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
