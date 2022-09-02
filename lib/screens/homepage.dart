// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Controller for managing pages.
    final _controller = PageController();

    //Page List
    List<Widget> news = [
      pagess(),
      pagess(),
      pagess(),
      pagess(),
      pagess(),
      pagess(),
      pagess(),
      pagess(),
      pagess(),
    ];

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: PageView(
              children: news,
              controller: _controller,
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ),
    );
  }
}

//Cutom Widget
class pagess extends StatelessWidget {
  const pagess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image.network(
            'https://picsum.photos/1280/720?image=16',
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
