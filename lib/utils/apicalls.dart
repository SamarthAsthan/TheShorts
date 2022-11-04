import 'dart:convert';

import 'package:theshorts/models/RegionsModel.dart';

import '../models/NewsDataModel.dart' show NewsDataModel;
import 'package:http/http.dart' as http;

class NewsCall {
  List<NewsDataModel> newsList = [];

// Fetching Json file.
  Future<List<NewsDataModel>> readJsonData(
      String category, country, language) async {
    var response = await http.get(Uri.parse(
        "http://faddugamers.com:8090/blog/?$category&language=$language&country=$country"));
    if (response.statusCode == 200) {
      Map<String, dynamic> listNews = json.decode(response.body);
      List<dynamic> data = listNews["articles"];

      return data.map((e) => NewsDataModel.fromJson(e)).toList();
    } else {
      return newsList;
    }
  }
}

class RegionCall {
  List<RegionModel> countryList = [];

// Fetching Json file.
  Future<List<RegionModel>> readJsonData() async {
    var response = await http.get(
        Uri.parse("https://mocki.io/v1/773719f3-1a06-4237-96a6-416e607f0dd8"));
    if (response.statusCode == 200) {
      Map<String, dynamic> countryList = json.decode(response.body);
      List<dynamic> data = countryList["Countries"];

      return data.map((e) => RegionModel.fromJson(e)).toList();
    } else {
      return countryList;
    }
  }
}
