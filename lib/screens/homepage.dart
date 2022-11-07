// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theshorts/constants.dart';
import 'package:theshorts/screens/discoverPage.dart';
import 'package:theshorts/screens/settings.dart';
import 'package:theshorts/screens/swipeNews.dart';

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
        extendBodyBehindAppBar: true,
        body: HomePageView(
          country: country,
          language: language,
        ));
  }
}

class HomePageView extends StatefulWidget {
  final String country, language;
  const HomePageView(
      {super.key, required this.country, required this.language});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _pageIndex = 0;

  @override
  void initState() {
    Constants.screensPageViewController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PageView(
              allowImplicitScrolling: true,
              //physics: AlwaysScrollableScrollPhysics(),
              controller: Constants.screensPageViewController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              children: [
               
                DiscoverPage(),
                SwipeNews(country: widget.country, language: widget.language),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
