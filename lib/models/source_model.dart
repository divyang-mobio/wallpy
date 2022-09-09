class Source {
  String? id, name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(id: json["id"] ?? "", name: json["name"] ?? "");
}
