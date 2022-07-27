import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../widgets/gridview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(TextResources().appTitle),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(IconsResources().search))
          ],
        ),
        body: gridView());
  }
}
