// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:theshorts/lists/newsLayout.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:theshorts/screens/discoverPage.dart';
import 'package:theshorts/utils/ApiCalls.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  final String country, language;
  HomePage({super.key, required this.country, required this.language});

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // Create a key
  @override
  Widget build(BuildContext context) {
    //Controller for managing pages.
    final _controller = PageController();

    return Scaffold(
        key: _key, // Assign the key to Scaffold.
        endDrawer: CustomEndDrawers(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          leadingWidth: 100.w,
          title: Text(
            "Home",
            style: GoogleFonts.poppins(
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverPage(),
                ),
                (route) => false,
              );
            },
          ),
          actions: [
            Row(
              children: [
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
                            HomePage(language: language, country: country),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                IconButton(
                    onPressed: () => _key.currentState!.openEndDrawer(),
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
        body: HomeBody(
          country: country,
          language: language,
        ));
  }
}

// HomePage Body
class HomeBody extends StatelessWidget {
  final String country, language;

  const HomeBody({super.key, required this.country, required this.language});

  @override
  Widget build(BuildContext context) {
    print("$country /// $language");
    return FutureBuilder(
      future:
          NewsCall().readJsonData('category=general', '$country', '$language'),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text("${data.error}"),
          );
        } else if (data.hasData) {
          var items = data.data as List<NewsDataModel>;
          return Container(
            child: RefreshIndicator(
              onRefresh: () async {
                items.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomePage(language: language, country: country),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: PageView.builder(
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
                allowImplicitScrolling: true,
              ),
            ),
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
                        height: 376.h,
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

// EndDrawer
class CustomEndDrawers extends StatelessWidget {
  const CustomEndDrawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.map_rounded),
            title: Text(
              'Select Country',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.share_rounded),
            title: Text(
              'Share App',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text(
              'Report Bug',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              'Support',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
