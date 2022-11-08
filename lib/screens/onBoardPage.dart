// ignore_for_file: use_build_context_synchronously

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:theshorts/constants.dart';
import 'package:theshorts/screens/homePage.dart';
import 'package:theshorts/utils/ApiCalls.dart';

import '../models/RegionsModel.dart';

class selectData {
  static late String country = "";
  static late List languageList = [];
}

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PageView(
                   allowImplicitScrolling: true,
                  //physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  children: [
                    OnBoardContent1(
                      pageController: _pageController,
                    ),
                    OnBoardContent2(
                      pageController: _pageController,
                    ),
                    OnBoardContent3(
                      country: '',
                      languageList: [],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    const Spacer(),
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 10.h,)
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 10.h : 6.h,
      width: 6.w,
      decoration: BoxDecoration(
          color: isActive
              ? Constants.primaryColor
              : Constants.primaryColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class OnBoard {
  final String description, path, title;
  OnBoard({required this.description, required this.path, required this.title});
}

class OnBoardContent1 extends StatelessWidget {
  OnBoardContent1({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Lottie.asset(
              'assets/lottie_file/welcome.json',
              repeat: true,
              reverse: false,
              animate: true,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "Welcome",
          style:TextStyle(
              fontSize: 37.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
            "Bad news travels at the speed of light, good news travels like molasses"),
        SizedBox(
          height: 19.h,
        ),
        CircleAvatar(
          radius: 30.sp,
          backgroundColor: Constants.primaryColor,
          child: IconButton(
              color: Colors.white,
              onPressed: () {
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ],
    );
  }
}

class OnBoardContent2 extends StatelessWidget {
  OnBoardContent2({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 250.h,
            width: 250.w,
            child: Lottie.asset(
              'assets/lottie_file/country.json',
              repeat: true,
              reverse: false,
              animate: true,
            ),
          ),
          
          Text(
            textAlign: TextAlign.start,
            "Which country's news do you want to read?",
            style: TextStyle(
                fontSize: 25.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5.h,
          ),
          FutureBuilder(
            future: RegionCall().readJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(
                  child: Text("${data.error}"),
                );
              } else if (data.hasData) {
                var items = data.data as List<RegionModel>;
                return Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    //elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: double.infinity),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        items[index].countryName.toString(),
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Constants.primaryColor,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                onTap: () {
                                  selectData.languageList =
                                      items[index].Languages!.toList();
                                  selectData.country = items[index]
                                      .countryName
                                      .toString()
                                      .toUpperCase();
                                  pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                },
                              ),
                            ],
                          );
                        },
                        itemCount: items.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const CupertinoActivityIndicator(
                          animating: true,
                          radius: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                              textAlign: TextAlign.center,
                              "Please wait, while fetching latest supported language form our server."),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "Whatever country and language you select now will be your default reading settings, You can also change this by going to the app's settings",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardContent3 extends StatelessWidget {
  OnBoardContent3({
    super.key,
    required this.languageList,
    required this.country,
  });
  final List languageList;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: SizedBox(
            height: 200.h,
            width: 200.w,
            child: Lottie.asset(
              'assets/lottie_file/language.json',
              repeat: true,
              reverse: false,
              animate: true,
            ),
          ),
        ),
       
        Align(
          child: Text(
            textAlign: TextAlign.start,
            "Please select your language.",
            style: TextStyle(
                fontSize: 25.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          child: Expanded(
            child: Card(
              color: Colors.white.withOpacity(0.8),
              //elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selectData.languageList[index],
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          onTap: () async {
                            APICacheDBModel cacheCountry = APICacheDBModel(
                                key: "savedCountry",
                                syncData: selectData.country.toUpperCase());
                            await APICacheManager().addCacheData(cacheCountry);
                            APICacheDBModel cacheLanguage = APICacheDBModel(
                                key: "savedLanguage",
                                syncData: selectData.languageList[index]
                                    .toString()
                                    .toUpperCase());
                            await APICacheManager().addCacheData(cacheLanguage);
                            APICacheManager().deleteCache("News");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  language: selectData.languageList[index]
                                      .toString()
                                      .toUpperCase(),
                                  country: selectData.country.toUpperCase(),
                                ),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                  itemCount: selectData.languageList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            "We are working hard to support more countries and languages",
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
