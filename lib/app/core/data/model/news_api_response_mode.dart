class NewsApiResponseModel {
  int? id;
  String? title;
  String? summary;
  String? link;
  String? image;
  String? published;

  NewsApiResponseModel(
      this.id, this.title, this.summary, this.link, this.image, this.published);

  NewsApiResponseModel.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    summary = json["summary"];
    link = json["link"];
    image = json["image"];
    published = json["published"];
  }
}
