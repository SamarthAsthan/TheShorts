// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:theshorts/constants.dart';
import 'package:theshorts/main.dart';
import 'package:theshorts/models/CategoriesModel.dart';
import 'package:theshorts/models/RegionsModel.dart';
import 'package:theshorts/screens/homePage.dart';
import 'package:theshorts/screens/categoryNewsPage.dart';
import 'package:theshorts/utils/apicalls.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leadingWidth: 100.w,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                "Back",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              )
            ],
          ),
          onTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: SafeArea(child: SettingsPageBody()),
    );
  }
}

class SettingsPageBody extends StatelessWidget {
  const SettingsPageBody({super.key});
  Future<List<int>> _f() async {
    return await Future.delayed(Duration(seconds: 3))
        .then((value) => [1, 3, 5, 56, 65]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RegionCall().readJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text("${data.error}"),
          );
        } else if (data.hasData) {
          var items = data.data as List<RegionModel>;
          return SizedBox(
            
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
