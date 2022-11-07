// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theshorts/constants.dart';
import 'package:theshorts/screens/homePage.dart';
import 'package:theshorts/screens/onBoardPage.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  //Constants.runTime=1;
  bool isSaved;
  var isCacheExist = await APICacheManager().isAPICacheKeyExist("savedCountry");
  var cachedCountry;
  var cachedLanguage;
  APICacheManager().deleteCache("Categories");
  if (!isCacheExist) {
    isSaved = false;
  } else {
    isSaved = true;
    cachedCountry = await APICacheManager().getCacheData("savedCountry");
    cachedLanguage = await APICacheManager().getCacheData("savedLanguage");
  }

  if (isSaved == true) {
    runApp(MainHomePage(
      savedCountry: cachedCountry.syncData,
      savedLanguage: cachedLanguage.syncData,
    ));
  } else {
    runApp(StartOnBoardPage());
  }
}

class MainHomePage extends StatelessWidget {
  const MainHomePage(
      {super.key, required this.savedCountry, required this.savedLanguage});
  final String savedCountry, savedLanguage;
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
          home: HomePage(country: savedCountry, language: 'ENGLISH'),
        );
      },
    );
  }
}

class StartOnBoardPage extends StatelessWidget {
  const StartOnBoardPage({super.key});

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
