import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';

class textstyle {
  static TextStyle boldtext() =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold);
  static TextStyle normaltext() => TextStyle(fontSize: 16.sp);
  static TextStyle normal() => TextStyle(color: appcolors.seccolor);
  static TextStyle smalltext() => TextStyle(fontSize: 14.sp);
  static TextStyle extrasmalltext() => TextStyle(fontSize: 12.sp);
  static TextStyle extralarge() => TextStyle(fontSize: 30.sp);
  static TextStyle large() => TextStyle(fontSize: 26.sp);
  static TextStyle medium() => TextStyle(fontSize: 20.sp);
  static TextStyle small() => TextStyle(fontSize: 18.sp);
  static TextStyle extrasmall() => TextStyle(fontSize: 16.sp);
  static TextStyle extrasmallbold() =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold);
  static TextStyle bold() => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: appcolors.seccolor,
      );
  static TextStyle home() => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
  static TextStyle content() =>
      TextStyle(color: appcolors.primarycolor, fontSize: 16);
  static TextStyle author() => TextStyle(
      color: appcolors.redcolor,
      overflow: TextOverflow.ellipsis,
      fontSize: 16,
      fontWeight: FontWeight.bold);
}
