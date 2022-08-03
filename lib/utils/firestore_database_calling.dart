import 'package:cloud_firestore/cloud_firestore.dart';
import '../resources/resources.dart';
import '../models/data_model.dart';

class FirebaseDatabase {
  final instances = FirebaseFirestore.instance.collection("Category");
  DocumentSnapshot? paginationData;
  bool isMore = true;
  List<Object> data = [];

  void update(DataModel dataModel) async {
    await instances
        .doc(dataModel.id.toString())
        .update({"image_fav": dataModel.fav});
  }

  Future<List<Object>> getAllData(String? category, bool isFavorite) async {
    final cat = (category == null && isFavorite == false)
        ? instances
        : (category != null && isFavorite == false)
            ? instances.where("image_category", isEqualTo: category)
            : (category == null && isFavorite == true)
                ? instances.where("image_fav", isEqualTo: true)
                : (category != null && isFavorite == true)
                    ? instances
                        .where("image_fav", isEqualTo: true)
                        .where("image_category", isEqualTo: category)
                    : instances;
    data.addAll(await getData(cat, isFavorite));
    return data;
  }

  Future<List<Object>> getData(
      Query<Map<String, dynamic>> instance, bool isFavorite) async {
    List<Object> rawData = [];
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
        rawData.addAll(
            rawList?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
                as Iterable<Object>);
        if (rawData.length != TextResources().itemLimit) {
          isMore = false;
        }
        if (!isFavorite) {
          for (var i = rawData.length - 1;
              i >= 1;
              i -= TextResources().adsInternalInList) {
            rawData.insert(i, "list");
          }
        }
      }
    }
    return rawData;
  }
}

class FirebaseSave {
  final instances = FirebaseFirestore.instance.collection("Category");

  Future<List<DataModel>> getAllData() async {
    return await getData();
  }

  Future<List<DataModel>> getData() async {
    List<DataModel>? rawData;
      var rawList = await instances.limit(TextResources().itemLimit).get().then((value) {
          return value.docChanges.map((e) => e.doc.data());

      });

        rawData =
            rawList.map((e) => DataModel.fromJson(e as Map<String, dynamic>)).toList();


    return rawData;
  }
}
