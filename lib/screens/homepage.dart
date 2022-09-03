// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Controller for managing pages.
    final _controller = PageController();

    //Page List
    List<Widget> news = [
      pagess(pageNo: 10),
      pagess(pageNo: 20),
      pagess(pageNo: 30),
      pagess(pageNo: 40),
      pagess(pageNo: 50),
      pagess(pageNo: 60),
      pagess(pageNo: 70),
      pagess(pageNo: 80),
      pagess(pageNo: 90),
      pagess(pageNo: 100),
      pagess(pageNo: 110),
      pagess(pageNo: 120),
      pagess(pageNo: 130),
      pagess(pageNo: 140),
      pagess(pageNo: 150),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Container(
        child: PageView(
          children: news,
          controller: _controller,
          scrollDirection: Axis.vertical,
          allowImplicitScrolling: true,
        ),
      ),
    );
  }
}

//Cutom Widget
class pagess extends StatelessWidget {
  const pagess({super.key, required this.pageNo});
  final int pageNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image.network(
            'https://picsum.photos/1280/720?image=$pageNo',
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
                  Image.network('https://picsum.photos/1280/720?image=$pageNo',
                      fit: BoxFit.cover),
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
                            'Lorem ipsum is placeholder text commonly used in the graphic, print.',
                            style: TextStyle(color: Colors.white),
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
