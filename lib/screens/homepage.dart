// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theshorts/lists/newslist.dart';
import 'package:theshorts/models/NewsDataModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Controller for managing pages.
    final _controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<NewsDataModel>;
            return Container(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return newpages(
                      photoLink: items[index].image_url.toString(),
                      title: items[index].title.toString(),
                      body: items[index].description.toString(),
                      author: items[index].author_name.toString(),
                      source: items[index].source_name.toString());
                },
                scrollDirection: Axis.vertical,
              ),
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
