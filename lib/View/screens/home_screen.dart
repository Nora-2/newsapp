import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Controller/news_controller.dart';
import 'package:news/View/screens/search.dart';
import 'package:news/View/widgets/category_widget.dart';
import 'package:news/View/widgets/home_widget.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/core/utils/appicons/app_icons.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:news/core/utils/widgets/bottomnav.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(NewsController());
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return closedialog(controller: controller, pageController: pageController);
  }
}

class closedialog extends StatelessWidget {
  const closedialog({
    super.key,
    required this.controller,
    required this.pageController,
  });

  final NewsController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.dialog(
          AlertDialog(
            title:  Text(Appstring.closingtitel),
            content:  Text(Appstring.closingcontent),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child:  Text(Appstring.close)),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child:  Text(Appstring.cancel)),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: appcolors.transcolor,
          leading:IconButton(
                onPressed: () {
                  Get.to(SearchScreen());
                },
                icon:  Icon(Appicons.search)) ,
          title: Text(
            Appstring.newsApp,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.changeThemeMode();
                },
                icon: Icon(controller.iconTheme())),
            
          ],
        ),
        body: PageView(
          onPageChanged: (index) {
            controller.changeNavBar(currentIndex: index);
          },
          controller: pageController,
          children: const [
            HomeWidget(),
            CategoryWidget(),
          ],
        ),
        bottomNavigationBar: GetBuilder<NewsController>(builder: (controller) {
          return bottomnav(pageController: pageController);
        }),
      ),
    );
  }
}
