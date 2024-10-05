import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/Controller/api_helper.dart';
import 'package:news/Model/news_model.dart';
import 'package:news/core/utils/appicons/app_icons.dart';

class NewsController extends GetxController {
  final box = GetStorage();
  final NewsHelper newsHelper = NewsHelper();
  final NewsHelper _newsHelper = Get.find<NewsHelper>();
  
  Map<String, List<NewsModel>> categoryData = {};
  List<NewsModel> searchResults = [];
  List<NewsModel> _headlines = [];
  List<NewsModel> get headlines => _headlines;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _error = '';
  String get error => _error;

  void changeThemeMode() {
    String? theme = box.read("theme");
    if (theme == null || theme == "dark") {
      Get.changeThemeMode(ThemeMode.light);
      box.write("theme", "light");
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      box.write("theme", "dark");
    }
    update();
  }

  IconData iconTheme() {
    String? theme = box.read("theme");
    return theme == "dark" ? Appicons.dark : Appicons.light;
  }

  int index = 0;

  void changeNavBar({required int currentIndex}) {
    index = currentIndex;
    update();
  }

  Future<void> getHeadlines({bool forceRefresh = false}) async {
    if (forceRefresh || _headlines.isEmpty) {
      _isLoading = true;
      _error = '';
      update();

      try {
        _headlines = await _newsHelper.getHeadlines(forceRefresh: forceRefresh);
      } catch (e) {
        _error = 'Failed to load headlines: $e';
      } finally {
        _isLoading = false;
        update();
      }
    }
  }

  Future<void> getSearch({required String query}) async {
    if (query.isNotEmpty) {
      try {
        searchResults = await newsHelper.searchNews(query: query);
      } catch (e) {
        Get.snackbar("Error", "Failed to search news");
        searchResults = [];
      }
    } else {
      searchResults.clear();
    }
    update();
  }

  Future<void> getCategory({required String category, bool forceRefresh = false}) async {
    if (forceRefresh || !categoryData.containsKey(category)) {
      try {
        final news = await newsHelper.getCategory(category: category);
        categoryData[category] = news;
        update([category]); // Notify listeners for this category
      } catch (e) {
        Get.snackbar('Error', 'Failed to load $category news');
      }
    }
  }

  List<NewsModel> getCategoryData(String category) {
    return categoryData[category] ?? [];
  }

  Future<void> refreshHeadlines() async {
    await getHeadlines(forceRefresh: true);
  }

  Future<void> refreshCategory(String category) async {
    await getCategory(category: category, forceRefresh: true);
  }

  @override
  void onInit() {
    getHeadlines();
    super.onInit();
  }
}
