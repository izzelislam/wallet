class TipsModel {
    int id;
    String title;
    String url;
    String thumbnail;

    TipsModel({
        required this.id,
        required this.title,
        required this.url,
        required this.thumbnail,
    });

    factory TipsModel.fromJson(Map<String, dynamic> json) => TipsModel(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "thumbnail": thumbnail,
    };
}