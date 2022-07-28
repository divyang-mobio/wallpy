import 'package:cloud_firestore/cloud_firestore.dart';
import '../resources/resources.dart';
import '../models/data_model.dart';

class FirebaseDatabase {
  final instances = FirebaseFirestore.instance.collection("Category");
  DocumentSnapshot? paginationData;
  bool isMore = true;
  List<DataModel> data = [];

  Future<List<DataModel>> getAllData(String? category) async {
    final cat = (category == null)
        ? instances
        : instances.where("image_category", isEqualTo: category);
    data.addAll(await getData(cat));
    return data;
  }

  Future<List<DataModel>> getData(Query<Map<String, dynamic>> instance) async {
    List<DataModel>? rawData;
    if (isMore) {
      var rawList = (paginationData?.data() == null)
          ? await instance.limit(TextResources().itemLimit).get().then((value) {
              if (value.docChanges.isEmpty) {
                isMore = false;
              } else {
                paginationData = value.docChanges.last.doc;
                return value.docChanges.map((e) => e.doc.data());
              }
            })
          : await instance
              .limit(TextResources().itemLimit)
              .startAfterDocument(paginationData!)
              .get()
              .then((value) {
              if (value.docChanges.isEmpty) {
                isMore = false;
              } else {
                paginationData = value.docChanges.last.doc;
                return value.docChanges.map((e) => e.doc.data());
              }
            });

      if (isMore) {
        rawData = rawList
            ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
            .toList();
        if (rawData?.length != TextResources().itemLimit) {
          isMore = false;
        }
      }
    }
    return rawData ?? [];
  }
}
