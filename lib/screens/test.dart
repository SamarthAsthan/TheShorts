import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (data.hasData) {
            var items = data.data as List<NewsDataModel>;
            //print(items);
            return Center(
              child: Text(data.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

List<NewsDataModel> newList = [];
// Fetching Json file.
Future<List<NewsDataModel>> ReadJsonData() async {
  final response = await http.get(
    Uri.parse("http://44.205.60.172/blog/"),
    headers: {
      "'accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzYW1hcnRoYXN0aGFuNUBnbWFpbC5jb20iLCJleHAiOjE2NjM3MzMzOTR9.Na9HCekajMbFRC2vw8NvMv_xSRSAiDV8xbDkZ7ybNVM"
    },
  );
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    debugPrint(response.body.toString());
    final list = json.decode(response.body) as List<dynamic>;
    debugPrint(list.toString());
    return list.map((e) => NewsDataModel.fromJson(e)).toList();
    //return newList;
  } else {
    return newList;
  }
  /*final jsondata = await rootBundle.rootBundle.loadString('jsonfile/news.json');
  final list = json.decode(jsondata) as List<dynamic>;
  debugPrint(list.toString());
  return list.map((e) => NewsDataModel.fromJson(e)).toList();*/
}

/*// Fetching Json file.
Future<List<NewsDataModel>> ReadJsonData() async {
  final jsondata = await rootBundle.rootBundle.loadString('jsonfile/news.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => NewsDataModel.fromJson(e)).toList();
}*/