import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:theshorts/models/RegionsModel.dart';

import '../models/NewsDataModel.dart' show NewsDataModel;
import 'package:http/http.dart' as http;

class NewsCall {
  List<NewsDataModel> newsList = [];

// Fetching Json file.
  Future<List<NewsDataModel>> readJsonData(
      String category, country, language) async {

    var isCacheExist = await APICacheManager().isAPICacheKeyExist("News");
    if (!isCacheExist) {
      var response = await http.get(Uri.parse("http://faddugamers.com:8090/blog/?$category&language=$language&country=$country"));
      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel =
        new APICacheDBModel(key: "News", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        Map<String, dynamic> listNews = json.decode(response.body);
        List<dynamic> data = listNews["articles"];
        print("API-Hit");
        return data.map((e) => NewsDataModel.fromJson(e)).toList();
      } else {
        return newsList;
      }
    } else {

      var cacheData = await APICacheManager().getCacheData("News");
      Map<String, dynamic> listNews = json.decode(cacheData.syncData);
      List<dynamic> data = listNews["articles"];
      print("Cache-Hit");

      return data.map((e) => NewsDataModel.fromJson(e)).toList();
    }
  }
}

class NewsCall2 {
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
