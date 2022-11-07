import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = const Color(0xFF0D9869);
  static List<dynamic> items = [];
  static int isNewsCached=0;
  static PageController newsPageViewController =
      PageController(viewportFraction: 1, keepPage: true);
  static PageController screensPageViewController =
      PageController(viewportFraction: 1, keepPage: true);
  

}