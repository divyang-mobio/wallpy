class DataModel {
  int image_id;
  String image_category, image_name, image_uid, image_url, image_timestamp;
  bool image_fav;

  DataModel(
      {required this.image_id,
      required this.image_name,
      required this.image_uid,
      required this.image_category,
      required this.image_fav,
      required this.image_timestamp,
      required this.image_url});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
      image_id: json["image_id"],
      image_name: json["image_name"],
      image_uid: json["image_uid"],
      image_category: json["image_category"],
      image_fav: json["image_fav"],
      image_timestamp: json["image_timestamp"],
      image_url: json["image_url"]);

  Map<String, dynamic> toJson() => {
        "image_id": image_id,
        "image_name": image_name,
        "image_uid": image_uid,
        "image_category": image_category,
        "image_fav": image_fav,
        "image_timestamp": image_timestamp,
        'image_url': image_url
      };
}
