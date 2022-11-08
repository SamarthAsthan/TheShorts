// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:theshorts/layouts/newsLayout.dart';
import 'package:theshorts/screens/discoverPage.dart';
import 'package:theshorts/utils/apicalls.dart';

import '../models/NewsDataModel.dart';

class TrendingPage extends StatelessWidget {
  final String pageheadline, category;
  const TrendingPage(
      {super.key, required this.pageheadline, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          '$pageheadline',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      TrendingPage(
                    pageheadline: pageheadline,
                    category: category,
                  ),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: TrendPage(
        category: category,
      ),
    );
  }
}

// Trending page Body
class TrendPage extends StatelessWidget {
  final String category;
  const TrendPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    print(category);
    return FutureBuilder(
      future:
          CategoryPageCall().readJsonData("category=$category", 'INDIA', 'ENGLISH'),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text("${data.error}"),
          );
        } else if (data.hasData) {
          var items = data.data as List<NewsDataModel>;

          return PageView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return newpages(
                  photoLink: items[index].image_url.toString(),
                  title: items[index].title.toString(),
                  body: items[index].description.toString(),
                  author: items[index].author_name.toString(),
                  source: items[index].source_name.toString(),
                  sourceUrl: items[index].source_url.toString(),
                  created_at: items[index].created_at.toString());
            },
            scrollDirection: Axis.vertical,
            allowImplicitScrolling: true,
          );
        } else {
          return Center(
            child: Shimmer.fromColors(
                // ignore: sort_child_properties_last
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0.sp),
                      child: Container(
                        height: 375.h,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0.sp),
                      child: Container(
                        height: 126.h,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 290.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade400),
          );
        }
      },
    );
  }
}
