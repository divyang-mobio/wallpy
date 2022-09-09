import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
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
        title: Text(TextResources().newsDetailAppTitle),
        actions: [
          IconButton(
              onPressed: () => Share.share("""${widget.articles.title}
                ${widget.articles.url ?? ""}"""),
              icon: Icon(IconsResources().share)),
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
              icon: Icon(IconsResources().openUrl))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child:
                    networkImages(widget.articles.urlToImage.toString(), null)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.articles.publishedAt.toString()),
                          Text(
                              "${TextResources().source} ${(widget.articles.source?.name).toString()}"),
                        ],
                      ),
                      Text(widget.articles.author.toString(),
                          overflow: TextOverflow.clip),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(widget.articles.title.toString(),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: BlocProvider.of<DarkModeBloc>(context).isDark
                              ? ColorResources().newsDetailTextDark
                              : ColorResources().newsDetailText)),
                  const SizedBox(height: 20),
                  Text(widget.articles.description.toString(),
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: BlocProvider.of<DarkModeBloc>(context).isDark
                              ? ColorResources().newsDetailTextDark
                              : ColorResources().newsDetailText)),
                  const SizedBox(height: 20),
                  Text(widget.articles.content.toString()),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
