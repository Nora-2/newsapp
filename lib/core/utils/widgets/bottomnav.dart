
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:news/Controller/news_controller.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/core/utils/appicons/app_icons.dart';
import 'package:news/core/utils/appstring/app_string.dart';
class bottomnav extends StatelessWidget {
   bottomnav({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  final controller = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: appcolors.primarycolor,
      unselectedItemColor: appcolors.seccolor,
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.index,
      onTap: (index) {
        controller.changeNavBar(currentIndex: index);
        pageController.jumpToPage(index);
       
      },
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Appicons.homefilled),
          activeIcon: Icon(Appicons.home),
          label: Appstring.home,
          tooltip:Appstring.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Appicons.ctegoryoutlined),
          activeIcon: Icon(Appicons.category),
          label: Appstring.category,
          tooltip: Appstring.category,
        ),
      ],
    );
  }
}
