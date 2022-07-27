import 'package:flutter/material.dart';
import '../screens/detail_screen.dart';
import '../resources/resources.dart';

gridCard(BuildContext context) {
  return GestureDetector(
    // onTap: () => Navigator.pushNamed(
    //   context,
    //   '/detail', arguments:
    //   // MaterialPageRoute(
    //   //   builder: (_) => const DetailScreen(
    //   //       link:
    //   //           "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/image%2Fnature-2.jpg?alt=media&token=3cb9c9b3-380d-4e69-b958-2f0ae15f5401"),
    //   // ),
    // ),
    child: Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Image.network(
          errorBuilder: (context, exception, stackTree) =>
              Image.asset(ImageResources().loadingError, fit: BoxFit.fill),
          loadingBuilder: (context, child, loadingProgress) {
            return (loadingProgress == null)
                ? child
                : const Center(child: CircularProgressIndicator.adaptive());
          },
          fit: BoxFit.fill,
          height: 300,
          "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/image%2Fnature-2.jpg?alt=media&token=3cb9c9b3-380d-4e69-b958-2f0ae15f5401"),
    ),
  );
}
