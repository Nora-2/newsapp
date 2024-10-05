import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Controller/news_controller.dart';
import 'package:news/View/widgets/list_items.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/shared/constant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late NewsController _newsController;
  final Map<String, RefreshController> _refreshControllers = {};

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: CategoryList.categoryItems.length, vsync: this);
    _controller.addListener(_handleTabSelection);

    _newsController = Get.find<NewsController>();

    for (var category in CategoryList.categoryItems) {
      _refreshControllers[category] = RefreshController();
    }

    // Preload data for the first category
    Future.microtask(() {
      _newsController.getCategory(category: CategoryList.categoryItems[0]);
    });
  }

  void _handleTabSelection() {
    if (_controller.indexIsChanging) {
      String category = CategoryList.categoryItems[_controller.index];
      if (!_newsController.categoryData.containsKey(category)) {
        _newsController.getCategory(category: category);
      }
      print('Selected category: $category');
      print('Current Tab Index: ${_controller.index}');

      // Notify all tabs to rebuild
      for (var category in CategoryList.categoryItems) {
        Get.find<NewsController>().update(['tab_$category']);
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabSelection);
    _controller.dispose();
    _refreshControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _onRefresh(String category) async {
    await _newsController.getCategory(category: category, forceRefresh: true);
    _refreshControllers[category]?.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          controller: _controller,
          indicatorColor: appcolors.transcolor,
          tabs: CategoryList.categoryItems.map((e) {
            return GetBuilder<NewsController>(
              id: 'tab_$e',
              builder: (_) {
                final isSelected =
                    _controller.index == CategoryList.categoryItems.indexOf(e);

                return Container(
                  width: 110,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? appcolors.primarycolor
                        : appcolors.transcolor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: isSelected
                            ? appcolors.primarycolor
                            : appcolors.transcolor),
                  ),
                  child: Center(
                    child: Text(
                      e,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected
                            ? appcolors.whicolor
                            : appcolors.seccolor,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: CategoryList.categoryItems.map((category) {
              return GetBuilder<NewsController>(
                id: category,
                builder: (controller) {
                  return SmartRefresher(
                    controller: _refreshControllers[category]!,
                    onRefresh: () => _onRefresh(category),
                    child: Skeletonizer(
                      enabled: controller.isLoading || !controller.categoryData.containsKey(category),
                      child: controller.categoryData.containsKey(category) && controller.getCategoryData(category).isNotEmpty
                          ? ListItems(list: controller.getCategoryData(category))
                          : _buildEmptyListPlaceholder(category),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyListPlaceholder(String category) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            color: Colors.grey[300],
          ),
          title: Container(
            height: 20,
            color: Colors.grey[300],
          ),
          subtitle: Container(
            height: 15,
            color: Colors.grey[300],
          ),
        );
      },
    );
  }
}