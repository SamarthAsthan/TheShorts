// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theshorts/screens/onBoardPage.dart';

void main(List<String> args) {
  runApp(TheShorts());
}

class TheShorts extends StatelessWidget {
  const TheShorts({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          debugShowCheckedModeBanner: false,
          title: "TheShorts",
          home: OnBoardPage(),
        );
      },
    );
  }
}
