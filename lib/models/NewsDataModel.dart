// ignore_for_file: non_constant_identifier_names

class NewsDataModel {
  String? title;
  String? description;
  String? author_name;
  String? source_name;
  String? source_url;
  String? image_url;
  int? created_at;
  String? inshorts_url;

  NewsDataModel(
      {this.title,
      this.description,
      this.author_name,
      this.source_name,
      this.source_url,
      this.image_url,
      this.created_at,
      this.inshorts_url});

  NewsDataModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    author_name = json["author_name"];
    source_name = json["source_name"];
    source_url = json["source_url"];
    image_url = json["image_url"];
    created_at = json["created_at"];
    inshorts_url = json["inshorts_url"];
  }
}
