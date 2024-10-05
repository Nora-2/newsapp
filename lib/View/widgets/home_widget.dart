import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Controller/news_controller.dart';
import 'package:news/View/widgets/homeitem.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final NewsController _newsController = Get.find<NewsController>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _newsController.getHeadlines());
  }

  Future<void> _onRefresh() async {
    await _newsController.getHeadlines(forceRefresh: true);
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (controller) {
        return Skeletonizer(
          enabled: controller.isLoading,
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: controller.error.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.error, textAlign: TextAlign.center),
                        ElevatedButton(
                          onPressed: () => controller.getHeadlines(),
                          child: Text(Appstring.retry),
                        ),
                      ],
                    ),
                  )
                : controller.headlines.isEmpty
                    ? Center(child: Text(Appstring.noHeadlines))
                    : Homeview(list: controller.headlines),
          ),
        );
      },
    );
  }
}