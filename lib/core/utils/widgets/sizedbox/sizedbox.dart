import 'package:flutter/widgets.dart';

class sized{
  static SizedBox h(double height) {
    return SizedBox(height: height);
  }

  static SizedBox w(double width) {
    return SizedBox(width: width);
  }

  static SizedBox hw(double height, double width) {
    return SizedBox(height: height, width: width);
  }
    static SizedBox  s16=sized.h(16);
     static SizedBox  s10=sized.h(10);
  static SizedBox  w10=sized.w(10);
     static SizedBox  s8=sized.h(8);
  static SizedBox  s20=sized.h(20);
}
