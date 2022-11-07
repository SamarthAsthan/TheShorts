// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, camel_case_types, non_constant_identifier_names, sort_child_properties_last

import 'dart:convert';
import 'dart:ui';

import 'package:api_cache_manager/api_cache_manager.dart';
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
              imageUrl: photoLink.contains("http")
                  ? "$photoLink"
                  : "https://uploads-us-west-2.insided.com/looker-en/attachment/d0a25f59-c9b7-40bd-b98e-de785bbd04e7.png"),
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
            child: Text('$title',
                maxLines: 2,
                style: GoogleFonts.notoSans(
                    fontSize: 18.sp,
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
                  style: GoogleFonts.notoSans(
                      fontSize: 15.sp, color: Colors.white)),
              Text('Publised $created_at',
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSans(
                      fontSize: 15.sp, color: Colors.white)),
            ],
          ),
        ),
        Container(
          height: 285.h,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 480.h, 0, 0),
                      child: Container(
                        height: 285.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.sp))),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 481.h, 12.w, 0),
                    child: Container(
                      height: 284.h,
                      child: SingleChildScrollView(
                        child: Text(body,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 20,
                            style: GoogleFonts.notoSans(
                                fontSize: 17.sp, color: Colors.grey.shade700)),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  height: 47.h,
                  child: InkWell(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: photoLink.contains("http")
                                ? "$photoLink"
                                : "https://uploads-us-west-2.insided.com/looker-en/attachment/d0a25f59-c9b7-40bd-b98e-de785bbd04e7.png"),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(.6),
                        ),
                        ClipRRect(
                          // Clip it cleanly.
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
                            child: Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 6.h, 0.w, 0.h),
                                child: Text(
                                  'Tap to know more',
                                  style: GoogleFonts.notoSans(
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
                      /*Future<void> _launchInBrowser(String url) async {
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: true,
                            forceWebView: true,
                            headers: <String, String>{
                              'header_key': 'header_value'
                            },
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchInBrowser('$sourceUrl');*/
                      APICacheManager().deleteCache("News");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
