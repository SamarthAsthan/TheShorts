// ignore_for_file: unnecessary_string_interpolations

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theshorts/constants.dart';
import 'package:theshorts/layouts/newsLayout.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:theshorts/screens/homePage.dart';
import 'package:theshorts/utils/apicalls.dart';

// SwipeNews Body
class SwipeNews extends StatefulWidget {
  final String country, language;

  const SwipeNews({super.key, required this.country, required this.language});

  @override
  State<SwipeNews> createState() => _SwipeNewsState();
}

class _SwipeNewsState extends State<SwipeNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key, // Assign the key to Scaffold.
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          centerTitle: true,
          leadingWidth: 100.w,
          elevation: 0,
          title: Text(
            "Home",
            style: GoogleFonts.notoSansSymbols(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          leading: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
                Text(
                  "Discover",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )
              ],
            ),
            onTap: () {
              Constants.screensPageViewController.animateToPage(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
              onPressed: () async {
                APICacheManager().deleteCache("News");
                Constants.newsPageViewController.animateToPage(0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease);
                Future.delayed(Duration(milliseconds: 1000), () {
                  setState(() {
                    Constants.isNewsCached = 1;
                  });

                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomePage(
                              language: widget.language,
                              country: widget.country),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: NewsCall().readJsonData(
              'category=general', widget.country, widget.language),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text("${data.error}"),
              );
            } else if (data.hasData) {
              var items = data.data as List<NewsDataModel>;

              if (Constants.isNewsCached != 1) {
                return Container(
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: Constants.newsPageViewController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return newpages(
                        photoLink: items[index].image_url.toString(),
                        title: items[index].title.toString(),
                        body: items[index].description.toString(),
                        author: items[index].author_name.toString(),
                        source: items[index].source_name.toString(),
                        sourceUrl: items[index].source_url.toString(),
                        created_at: items[index].created_at.toString(),
                      );
                    },
                    scrollDirection: Axis.vertical,
                  ),
                );
              } else {
                return Stack(
                  children: [
                    PageView.builder(
                      allowImplicitScrolling: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: Constants.newsPageViewController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return newpages(
                          photoLink: items[index].image_url.toString(),
                          title: items[index].title.toString(),
                          body: items[index].description.toString(),
                          author: items[index].author_name.toString(),
                          source: items[index].source_name.toString(),
                          sourceUrl: items[index].source_url.toString(),
                          created_at: items[index].created_at.toString(),
                        );
                      },
                      scrollDirection: Axis.vertical,
                    ),
                    Center(
                      child: Container(
                        height: 100.h,
                        width: 100.w,
                        color: Colors.white,
                        child: CupertinoActivityIndicator(
                          animating: true,
                          radius: 15,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              }
              ;
            } else {
              return Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  radius: 15,
                  color: Constants.primaryColor,
                ),
              );
            }
          },
        ));
  }
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class SwipeNewsBody extends StatefulWidget {
  const SwipeNewsBody(
      {super.key, required this.country, required this.language});
  final String country, language;

  @override
  State<SwipeNewsBody> createState() => _SwipeNewsBodyState();
}

class _SwipeNewsBodyState extends State<SwipeNewsBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NewsCall()
          .readJsonData('category=general', widget.country, widget.language),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text("${data.error}"),
          );
        } else if (data.hasData) {
          var items = data.data as List<NewsDataModel>;

          return Constants.isNewsCached != 1
              ? Container(
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: Constants.newsPageViewController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return newpages(
                        photoLink: items[index].image_url.toString(),
                        title: items[index].title.toString(),
                        body: items[index].description.toString(),
                        author: items[index].author_name.toString(),
                        source: items[index].source_name.toString(),
                        sourceUrl: items[index].source_url.toString(),
                        created_at: items[index].created_at.toString(),
                      );
                    },
                    scrollDirection: Axis.vertical,
                  ),
                )
              : Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 15,
                    color: Colors.red,
                  ),
                );
          ;
        } else {
          return Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 15,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
