// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' as rootBundle;

import '../main.dart';

//Cutom Widget
class newpages extends StatelessWidget {
  const newpages(
      {super.key,
      required this.photoLink,
      required this.title,
      required this.body,
      required this.author,
      required this.source});
  final String photoLink, title, body, author, source;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              placeholder: (context, url) => Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
              imageUrl: '$photoLink',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$title",
              style: TextStyle(
                  fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 18),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 1, 8, 100),
            child: Text(
              "$body",
              style: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15),
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              height: 46,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(imageUrl: '$photoLink', fit: BoxFit.cover),
                  ClipRRect(
                    // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                          child: Text(
                            '- $author',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveTextSize()
                                  .getadaptiveTextSize(context, 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<NewsDataModel> newList = [];
// Fetching Json file.
Future<List<NewsDataModel>> ReadJsonData() async {
  /*final login =
      await http.post(Uri.parse("http://44.205.60.172/login"), headers: {
    "accept": "application/json",
  }, body: {
    "username": "samarthasthan5@gmail.com",
    "password": "Police@007"
  });
  final list = json.decode(login.body);
  var apiKey = list["access_token"];
  print(list["access_token"])*/
  final response = await http.get(Uri.parse("http://44.205.60.172/blog/"));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    //debugPrint(response.body.toString());
    final list = json.decode(response.body) as List<dynamic>;
    //debugPrint(list.toString());
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
