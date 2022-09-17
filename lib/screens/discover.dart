// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:theshorts/screens/homepage.dart';
import 'package:theshorts/screens/trending.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            child: Row(
              children: [
                Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Discoverbody(),
    );
  }
}

class Discoverbody extends StatelessWidget {
  const Discoverbody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      crossAxisCount: 3,
      children: [
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: const Icon(
                Icons.trending_up_sharp,
                color: Colors.white,
                size: 50,
              ),
            ),
            color: Colors.deepPurple,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TrendingPage()));
          },
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Business'),
          ),
          color: Colors.indigo,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Politics'),
          ),
          color: Colors.teal,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Technology'),
          ),
          color: Colors.cyan,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Startup'),
          ),
          color: Colors.yellow,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Science'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Enterainment'),
          ),
          color: Colors.purple,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('International'),
          ),
          color: Colors.blue,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Automobile'),
          ),
          color: Colors.orange,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Fashion'),
          ),
          color: Colors.red,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Education'),
          ),
          color: Colors.indigo,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: const Text('Health & Fitness'),
          ),
          color: Colors.teal,
        ),
      ],
    );
  }
}
