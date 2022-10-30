// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, camel_case_types, non_constant_identifier_names, sort_child_properties_last

import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theshorts/models/NewsDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

//Cutom Widget
class newpages extends StatelessWidget {
  const newpages(
      {super.key,
      required this.photoLink,
      required this.title,
      required this.body,
      required this.author,
      required this.source,
      required this.sourceUrl,
      required this.created_at});
  final String photoLink, title, body, author, source, sourceUrl, created_at;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Stack(children: [
          CachedNetworkImage(
              placeholder: (context, url) => SizedBox(
                    child: CupertinoActivityIndicator(
                      animating: true,
                      radius: 20,
                    ),
                  ),
              height: 500.h,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: '$photoLink'),
          Container(
            height: 500.h,
            width: double.infinity,
            color: Colors.black.withOpacity(.6),
          ),
        ]),
        Padding(
          padding: EdgeInsets.fromLTRB(15.w, 386.h, 15.w, 365.h),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: AutoSizeText('$title',
                style: GoogleFonts.poppins(
                    fontSize: 30.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 85.h, 12.w, 0.h),
          child: Divider(
            color: Colors.grey,
            thickness: 2.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15.w, 105.h, 15.w, 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$author',
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, color: Colors.white)),
              Text('Publised $created_at',
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, color: Colors.white)),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 480.h, 0, 0),
            child: Container(
              height: 332.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.sp))),
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 500.h, 20.w, 0),
          child: Text('$body',
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(fontSize: 18.sp, color: Colors.black)),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SizedBox(
            height: 47.h,
            child: InkWell(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(imageUrl: '$photoLink', fit: BoxFit.cover),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(.6),
                  ),
                  ClipRRect(
                    // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 6.h, 0.w, 0.h),
                          child: Text(
                            'Tap to know more',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                Future<void> _launchInBrowser(String url) async {
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: true,
                      forceWebView: true,
                      headers: <String, String>{'header_key': 'header_value'},
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                _launchInBrowser('$sourceUrl');
              },
            ),
          ),
        ),
      ],
    );
  }
}

List<NewsDataModel> newsList = [];
// Fetching Json file.
Future<List<NewsDataModel>> ReadJsonData(String category) async {
  var response =
      await http.get(Uri.parse("http://44.205.60.172/blog/?$category"));
  if (response.statusCode == 200) {
    Map<String, dynamic> listNews = json.decode(response.body);
    List<dynamic> data = listNews["articles"];

    print(data.length);
    return data.map((e) => NewsDataModel.fromJson(e)).toList();
  } else {
    return newsList;
  }
}
