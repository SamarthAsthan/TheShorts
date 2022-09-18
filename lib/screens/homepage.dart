// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unused_local_variable

import 'package:flutter/material.dart';
import 'package:theshorts/lists/newslist.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:theshorts/screens/discover.dart';
import '../main.dart';
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
          leadingWidth: 100,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
                Text(
                  "Discover",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                          AdaptiveTextSize().getadaptiveTextSize(context, 15)),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiscoverPage()));
            },
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
            title: Text(
              'Select Country',
              style: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 18),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category_rounded),
            title: Text(
              'Select Interest',
              style: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 18),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.share_rounded),
            title: Text(
              'Share App',
              style: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 18),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text(
              'Report Bug',
              style: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 18),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              'Support',
              style: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 18),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
