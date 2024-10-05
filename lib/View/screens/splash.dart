import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news/Controller/api_helper.dart';
import 'package:news/View/screens/home_screen.dart';
import 'package:news/Controller/news_controller.dart';
import 'package:news/core/utils/appimage/app_images.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:news/core/utils/textstyle/textstyle.dart';
import 'package:news/core/utils/widgets/sizedbox/sizedbox.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Appimage.splach, width: 300.w, height: 300.h),
            sized.s20,
            Text(Appstring.letsDiscover, style: textstyle.bold()),
            sized.s20,
          ],
        ),
      ),
    );
  }

  Future<void> _initializeDependencies() async {
    // Initialize NewsHelper
    await Get.putAsync(() async => NewsHelper());

    // Initialize NewsController
    Get.put(NewsController());

    // Delay for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to HomeScreen
    Get.off(() => HomeScreen());
  }
}
