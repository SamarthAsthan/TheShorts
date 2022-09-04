// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:theshorts/lists/newslist.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'trending.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    //Controller for managing pages.
    final _controller = PageController();

    return Scaffold(
        key: _key, // Assign the key to Scaffold.
        endDrawer: CustomEndDrawers(),
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TrendingPage()));
            },
            icon: Icon(
              Icons.trending_up_rounded,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => _key.currentState!.openEndDrawer(),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ))
          ],
        ),
        body: HomeBody());
  }
}

// HomePage Body
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

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
          return Container(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return newpages(
                  photoLink: items[index].image_url.toString(),
                  title: items[index].title.toString(),
                  body: items[index].description.toString(),
                  author: items[index].author_name.toString(),
                  source: items[index].source_name.toString(),
                );
              },
              scrollDirection: Axis.vertical,
              allowImplicitScrolling: true,
            ),
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
            title: Text('Select Country'),
          ),
          ListTile(
            leading: Icon(Icons.category_rounded),
            title: Text('Select Interest'),
          ),
          ListTile(
            leading: Icon(Icons.share_rounded),
            title: Text('Share App'),
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Report Bug'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Support'),
          ),
        ],
      )),
    );
  }
}

class NightModeSwitch extends StatelessWidget {
  const NightModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      cornerRadius: 10,
      fontSize: 30,
      iconSize: 25,
      activeBgColors: [
        [Colors.deepPurple],
        [Colors.deepPurple]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.black26,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      icons: [Icons.sunny, Icons.mode_night],
      onToggle: (index) {
        print('Selected item Position: $index');
      },
    );
  }
}
