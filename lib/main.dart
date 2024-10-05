
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/View/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
     ScreenUtil.init(
      context,
      designSize: Size(375, 900), // Adjust based on your design
      minTextAdapt: true,
      splitScreenMode: false,
    );
    
    debugPrint(box.read("theme"));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: box.read("theme") == null || box.read("theme") != "dark"
          ? ThemeMode.light
          : ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
