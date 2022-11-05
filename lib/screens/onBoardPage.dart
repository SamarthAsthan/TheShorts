// ignore_for_file: use_build_context_synchronously

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PageView(
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
                    Spacer(),
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
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
      duration: Duration(milliseconds: 300),
      height: isActive ? 10.h : 6.h,
      width: 20.w,
      decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.green.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(12))),
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
      mainAxisAlignment: MainAxisAlignment.start,
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
          style: GoogleFonts.poppins(
              fontSize: 30.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
        SizedBox(
          height: 19.h,
        ),
        CircleAvatar(
          radius: 30.sp,
          backgroundColor: Colors.green,
          child: IconButton(
              color: Colors.white,
              onPressed: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
              icon: Icon(Icons.arrow_forward_ios_rounded)),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 250.h,
              width: 250.w,
              child: Lottie.asset(
                'assets/lottie_file/country.json',
                repeat: true,
                reverse: false,
                animate: true,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Select your country",
            style: GoogleFonts.poppins(
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
                return Container(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                      items[index].countryName.toString(),
                                       style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                                    onTap: () {
                                      selectData.languageList =
                                          items[index].Languages!.toList();
                                      selectData.country = items[index]
                                          .countryName
                                          .toString()
                                          .toUpperCase();
                                      pageController.animateToPage(2,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: items.length,
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 100.h,
                  width: 100.w,
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                      radius: 20,
                    ),
                  ),
                );
              }
            },
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
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 250.h,
              width: 250.w,
              child: Lottie.asset(
                'assets/lottie_file/language.json',
                repeat: true,
                reverse: false,
                animate: true,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "Select your language",
          style: GoogleFonts.poppins(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          child: Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              selectData.languageList[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () async {
                              APICacheDBModel cacheCountry =
                              APICacheDBModel(key: "savedCountry", syncData:selectData.country.toUpperCase() );
                              await APICacheManager().addCacheData(cacheCountry);
                              APICacheDBModel cacheLanguage =
                              APICacheDBModel(key: "savedLanguage", syncData:selectData.languageList[index]
                                  .toString()
                                  .toUpperCase() );
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
                      ),
                    );
                  },
                  itemCount: selectData.languageList.length,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
