class DataModel {
  int id;
  String name, uid, url;
  List category;
  bool fav;
  DateTime timestamp;

  DataModel(
      {required this.id,
      required this.name,
      required this.uid,
      required this.category,
      required this.fav,
      required this.timestamp,
      required this.url});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
      id: json["image_id"],
      name: json["image_name"],
      uid: json["image_uid"],
      category: json["image_category"],
      fav: json["image_fav"],
      timestamp:
          DateTime.parse(json["image_timestamp"].toDate().toString()),
      url: json["image_url"]);
}
