// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theshorts/main.dart';
import 'package:theshorts/screens/homepage.dart';
import 'package:theshorts/screens/trending.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Discover",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            child: Row(
              children: [
                Text(
                  "Home",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
                (route) => false,
              );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: AutoSizeText(
            "Choose a topic to start reading",
            style: GoogleFonts.poppins(
                fontSize: 30.sp, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Circle(
                    title: 'Trending',
                    filePath: 'assets/images/Trending.png',
                    pageTitle: 'Trending',
                    categoryDiscover: 'general==trending',
                  ),
                  Circle(
                    title: 'Buisness',
                    filePath: 'assets/images/Briefcase.png',
                    pageTitle: 'Buisness',
                    categoryDiscover: 'category=business',
                  ),
                  Circle(
                    title: 'Politics',
                    filePath: 'assets/images/Politics.png',
                    pageTitle: 'Politics',
                    categoryDiscover: 'category=politics',
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Circle(
                    title: 'Tech',
                    filePath: 'assets/images/Technology.png',
                    pageTitle: 'Technology',
                    categoryDiscover: 'category=tech',
                  ),
                  Circle(
                    title: 'Startup',
                    filePath: 'assets/images/startup.png',
                    pageTitle: 'Startup',
                    categoryDiscover: '',
                  ),
                  Circle(
                    title: 'Science',
                    filePath: 'assets/images/Science.png',
                    pageTitle: 'Science',
                    categoryDiscover: 'category=science',
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Circle(
                    title: 'Fun',
                    filePath: 'assets/images/Entertainment.png',
                    pageTitle: 'Entertainment',
                    categoryDiscover: 'category=fun',
                  ),
                  Circle(
                    title: 'World',
                    filePath: 'assets/images/Earth.png',
                    pageTitle: 'World',
                    categoryDiscover: 'category=world',
                  ),
                  Circle(
                    title: 'Wheels',
                    filePath: 'assets/images/Automobile.png',
                    pageTitle: 'Automobile',
                    categoryDiscover: 'category=wheels',
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Circle(
                    title: 'Fashion',
                    filePath: 'assets/images/Fashion.png',
                    pageTitle: 'Fashion',
                    categoryDiscover: 'category=fashion',
                  ),
                  Circle(
                    title: 'Education',
                    filePath: 'assets/images/Education.png',
                    pageTitle: 'Education',
                    categoryDiscover: 'category=education',
                  ),
                  Circle(
                    title: 'Sports',
                    filePath: 'assets/images/Sports.png',
                    pageTitle: 'Sports',
                    categoryDiscover: 'category=sports',
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class Circle extends StatelessWidget {
  final String pageTitle;
  final String filePath;
  final String title;
  final String categoryDiscover;
  const Circle(
      {super.key,
      required this.filePath,
      required this.title,
      required this.pageTitle,
      required this.categoryDiscover});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple, width: 2.sp),
          shape: BoxShape.circle,
        ),
        child: Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrendingPage(
                    pageheadline: '$pageTitle',
                    categoryTrendingPage: '$categoryDiscover',
                  ),
                ),
              );
            },
            customBorder: const CircleBorder(),
            child: Ink(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    '$filePath',
                    height: 50.h,
                    width: 50.w,
                  ),
                  AutoSizeText(
                    '$title',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14.sp),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
