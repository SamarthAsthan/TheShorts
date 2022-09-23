// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../lists/newslist.dart';
import '../models/NewsDataModel.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: TrendPage(),
    );
  }
}

// Trending page Body
class TrendPage extends StatelessWidget {
  const TrendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text("${data.error}"),
          );
        } else if (data.hasData) {
          var items = data.data as List<NewsDataModel>;
          var reversedList = List.from(items.reversed);
          return PageView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return newpages(
                photoLink: reversedList[index].image_url.toString(),
                title: reversedList[index].title.toString(),
                body: reversedList[index].description.toString(),
                author: reversedList[index].author_name.toString(),
                source: reversedList[index].source_name.toString(),
              );
            },
            scrollDirection: Axis.vertical,
            allowImplicitScrolling: true,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
