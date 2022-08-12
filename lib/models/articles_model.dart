class Articles {
  String? author, title, description, url, urlToImage, content, publishedAt;

  Articles(
      {this.title,
      this.author,
      this.url,
      this.description,
      this.content,
      this.publishedAt,
      this.urlToImage});

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
      title: json["title"] ?? "",
      author: json["author"] ?? "",
      url: json["url"] ?? "",
      description: json["description"] ?? "",
      content: json["content"] ?? "",
      publishedAt:
          json["publishedAt"].substring(0, json["publishedAt"].indexOf('T')) ??
              "",
      urlToImage: json["urlToImage"] ?? "");
}
