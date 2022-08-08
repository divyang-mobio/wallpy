import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("no data");//_listView();
  }
}
//
// ListView _listView() {
//   return ListView.builder(
//       itemCount: collectionData.length,
//       itemBuilder: (context, index) {
//         return _listCard(context, collectionData[index]);
//       });
// }
//
// _listCard(context, CollectionModel data) {
//   return Container(
//     decoration: BoxDecoration(
//       image: DecorationImage(image: NetworkImage(data.link), fit: BoxFit.cover),
//       borderRadius: const BorderRadius.all(Radius.circular(20))
//     ),
//     margin: const EdgeInsets.all(8.0),
//     padding: const EdgeInsets.all(16.0),
//     // color: Colors.red,
//     height: 110,
//     width: MediaQuery.of(context).size.width * .8,
//     child: Text(
//       data.name,
//       style: Theme.of(context)
//           .textTheme
//           .headline4
//           ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
//     ),
//   );
// }
