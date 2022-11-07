// ignore_for_file: non_constant_identifier_names

class CategoriesModel {
  String? name;
  String? url;
  String? keyword;

  CategoriesModel({
    this.name,
    this.url,
    this.keyword,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    url = json["url"];
    keyword = json["keyword"];
  }
}
