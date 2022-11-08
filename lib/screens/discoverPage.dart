// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:theshorts/constants.dart';
import 'package:theshorts/main.dart';
import 'package:theshorts/models/CategoriesModel.dart';
import 'package:theshorts/models/RegionsModel.dart';
import 'package:theshorts/screens/homePage.dart';
import 'package:theshorts/screens/categoryNewsPage.dart';
import 'package:theshorts/screens/settings.dart';
import 'package:theshorts/utils/apicalls.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leadingWidth: 100.w,
        title: Text(
          "Discover",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            child: Row(
              children: [
                Text(
                  "Home",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () {
              Constants.screensPageViewController.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
          ),
        ],
        leading: InkWell(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
      ),
      body: SafeArea(child: Discoverbody()),
    );
  }
}

class Discoverbody extends StatelessWidget {
  const Discoverbody({super.key});
  Future<List<int>> _f() async {
    return await Future.delayed(Duration(seconds: 3))
        .then((value) => [1, 3, 5, 56, 65]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FutureBuilder(
          future: CategoryCall().readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text("${data.error}"),
              );
            } else if (data.hasData) {
              var items = data.data as List<CategoriesModel>;

              return Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFixedExtentList(
                      itemExtent: 50.sp,
                      delegate: SliverChildListDelegate([
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AutoSizeText(
                              "Choose a topic to start reading",
                              style: TextStyle(
                                  fontSize: 25.sp, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ]),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: .7,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Circle(
                              url: items[index].url.toString(),
                              title: items[index].name.toString(),
                              pageTitle: items[index].name.toString(),
                              categoryDiscover: items[index].keyword.toString(),
                              index: index,
                            ),
                          );
                        },
                        childCount: items.length,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const CupertinoActivityIndicator(
                        animating: true,
                        radius: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                            textAlign: TextAlign.center, "Loading Categories"),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class Circle extends StatelessWidget {
  const Circle(
      {super.key,
      required this.url,
      required this.title,
      required this.pageTitle,
      required this.categoryDiscover,
      required this.index});

  final String categoryDiscover;
  final String url;
  final String pageTitle;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Constants.primaryColor, width: 0.sp),
          shape: BoxShape.rectangle,
        ),
        child: Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrendingPage(
                    pageheadline: '$pageTitle',
                    category: '$categoryDiscover',
                  ),
                ),
              );
            },
            customBorder: const CircleBorder(),
            child: Ink(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Stack(
                children: [
                  index != 0
                      ? Align(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => SizedBox(
                                child: CupertinoActivityIndicator(
                                  animating: true,
                                  radius: 10,
                                ),
                              ),
                              imageUrl: url,
                            ),
                          ),
                        )
                      : Align(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                                placeholder: (context, url) => SizedBox(
                                      child: CupertinoActivityIndicator(
                                        animating: true,
                                        radius: 10,
                                      ),
                                    ),
                                fit: BoxFit.cover,
                                height: double.infinity,
                                imageUrl: url),
                          ),
                          alignment: Alignment.bottomCenter,
                        ),
                  Align(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        width: double.infinity,
                        height: 80.h,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              //create 2 white colors, one transparent
                              Color.fromARGB(0, 255, 255, 255),
                              Color.fromARGB(255, 255, 255, 255)
                            ])),
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Constants.primaryColor, width: 1.sp),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: index != 0
                          ? AutoSizeText(
                              '$title',
                              minFontSize: 15,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.sp),
                              textAlign: TextAlign.center,
                            )
                          : SizedBox(),
                    ),
                    alignment: Alignment.bottomCenter,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
