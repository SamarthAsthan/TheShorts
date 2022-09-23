// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:theshorts/screens/test.dart';
import 'screens/homepage.dart';

void main(List<String> args) {
  runApp(TheShorts());
}

class TheShorts extends StatelessWidget {
  const TheShorts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TheShorts",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
