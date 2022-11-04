// ignore_for_file: non_constant_identifier_names

class RegionModel {
  String? countryName;
  List? Languages;

  RegionModel({
    this.countryName,
    this.Languages,
  });

  RegionModel.fromJson(Map<String, dynamic> json) {
    countryName = json["Name"];
    Languages = json["Languages"];
  }

  get length => null;
}
