// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:theshorts/lists/newslist.dart';
import 'package:theshorts/screens/discover.dart';

import '../models/NewsDataModel.dart';

class TrendingPage extends StatelessWidget {
  final String pageheadline, categoryTrendingPage;
  const TrendingPage(
      {super.key,
      required this.pageheadline,
      required this.categoryTrendingPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          '$pageheadline',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DiscoverPage(),
              ),
              (route) => false,
            );
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
                    categoryTrendingPage: categoryTrendingPage,
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
        categoryTrendPage: categoryTrendingPage,
      ),
    );
  }
}

// Trending page Body
class TrendPage extends StatelessWidget {
  final String categoryTrendPage;
  const TrendPage({super.key, required this.categoryTrendPage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReadJsonData(categoryTrendPage),
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
