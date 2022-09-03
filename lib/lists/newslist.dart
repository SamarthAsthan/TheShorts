// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image.network(
            '$photoLink',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$title",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "$body",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              height: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network('$photoLink', fit: BoxFit.cover),
                  ClipRRect(
                    // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '$author ($source)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

Future<List<NewsDataModel>> ReadJsonData() async {
  final jsondata = await rootBundle.rootBundle.loadString('jsonfile/news.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => NewsDataModel.fromJson(e)).toList();
}
