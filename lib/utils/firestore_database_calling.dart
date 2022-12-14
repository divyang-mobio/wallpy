import 'package:cloud_firestore/cloud_firestore.dart';
import '../resources/resources.dart';
import '../models/data_model.dart';
import 'dart:developer';

class FirebaseDatabase {
  final instances =
      FirebaseFirestore.instance.collection(TextResources().fireStoreCategory);
  DocumentSnapshot? paginationData;
  bool isMore = true;
  List<Object> data = [];

  void update(DataModel dataModel) async {
    await instances
        .doc(dataModel.id.toString())
        .update({TextResources().fireStoreImgFav: dataModel.fav});
  }

  Future<List<Object>> getAllData(String? category, bool isFavorite,
      String? query, bool isSearch, bool showAds) async {
    final categoryInstance = (category == null &&
            isFavorite == false &&
            query == null)
        ? instances
        : (category != null && isFavorite == false && query == null)
            ? instances.where(TextResources().fireStoreImgCat,
                isEqualTo: category)
            : (category == null && isFavorite == true && query == null)
                ? instances.where(TextResources().fireStoreImgFav,
                    isEqualTo: true)
                : (category != null && isFavorite == true && query == null)
                    ? instances
                        .where(TextResources().fireStoreImgFav, isEqualTo: true)
                        .where(TextResources().fireStoreImgCat,
                            isEqualTo: category)
                    : (query != null && isFavorite == false)
                        ? instances.where(TextResources().fireStoreImgCat,
                            arrayContains: query)
                        : (query != null && isFavorite == true)
                            ? instances
                                .where(TextResources().fireStoreImgCat,
                                    isEqualTo: query)
                                .where(TextResources().fireStoreImgFav,
                                    isEqualTo: true)
                            : instances;
    if (isSearch) {
      paginationData = null;
      isMore = true;
      data = [];
    }
    data.addAll(await getData(categoryInstance, showAds));
    return data;
  }

  Future<List<Object>> getData(
      Query<Map<String, dynamic>> instance, bool showAds) async {
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
        // if (showAds) {
        //   for (var i = rawData.length - 1;
        //       i >= 1;
        //       i -= TextResources().adsInternalInList) {
        //     rawData.insert(i, "list");
        //   }
        // }
      }
    }
    return rawData;
  }

  getCategoryData(bool dataAndName) async {
    final instances = FirebaseFirestore.instance.collection("Category");

    QuerySnapshot querySnapshot = await instances.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Set<String> finalcategory = <String>{};
    List<Map> finalproduct = [];
    List<Map<String, dynamic>> finalImage = [];

    for (var element in allData) {
      Map<String, dynamic> ele =
          (element ?? <String, dynamic>{}) as Map<String, dynamic>;
      List<dynamic> imagecategory = ele['image_category'] ?? <dynamic>[];

      for (var ele in imagecategory) {
        finalcategory.add(ele.toString());
      }
    }

    if (dataAndName) {
      for (var element in finalcategory) {
        var img = await instances
            .where(
              "image_category",
              arrayContains: element,
            )
            .get();
        var data = img.docs.map((doc) => doc.data()).toList();
        finalImage.add({'name': element, 'data': data});
      }

      for (var category in finalcategory) {
        for (var data in finalImage) {
          if (category.contains(data['name'])) {
            finalproduct.add(data);
          }
        }
      }
    }
    if (!dataAndName) {
      finalcategory.add("other");
    }
    if (dataAndName) {
      finalproduct.insert(0, {
        'name': "gradiant",
        'data': [
          {
            "image_url":
                "https://firebasestorage.googleapis.com/v0/b/wallpy-72a92.appspot.com/o/image%2Fimage_picker2424713006920189922.png?alt=media&token=674d3c2f-9c19-434e-a0e9-fbb0ed08ab86"
          }
        ]
      });
    }
    return dataAndName ? finalproduct : finalcategory;
  }
}

class FireStoreForBackgroundService {
  final instances =
      FirebaseFirestore.instance.collection(TextResources().fireStoreCategory);

  Future<List<DataModel>> getAllData(bool isFavorite) async {
    List<DataModel> data = [];
    final cat = (isFavorite == false)
        ? instances
        : instances.where(TextResources().fireStoreImgFav, isEqualTo: true);
    data.addAll(await getData(cat));
    return data;
  }

  Future<List<DataModel>> getData(Query<Map<String, dynamic>> cat) async {
    List<DataModel>? rawData;
    var rawList =
        await cat.limit(TextResources().itemLimit).get().then((value) {
      return value.docChanges.map((e) => e.doc.data());
    });

    rawData = rawList
        .map((e) => DataModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return rawData;
  }
}

class CheckAdminFireStore {
  final instances = FirebaseFirestore.instance.collection("admin");

  Future<bool> getData(String email) async {
    var rawList = await instances
        .where("email", isEqualTo: email)
        .limit(TextResources().itemLimit)
        .get()
        .then((value) => value.docChanges.map((e) => e.doc.data()));

    return rawList.isEmpty ? false : true;
  }
}
