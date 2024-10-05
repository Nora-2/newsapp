import 'package:get/get.dart';
import 'package:news/Model/news_model.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:news/shared/constant.dart';

class CacheEntry {
  final List<NewsModel> data;
  final DateTime timestamp;
  static const Duration _cacheExpiration =
      Duration(minutes: 15); // Cache expiration time

  CacheEntry(this.data) : timestamp = DateTime.now();

  bool isExpired() {
    return DateTime.now().difference(timestamp) > _cacheExpiration;
  }
}

class NewsHelper extends GetConnect implements GetxService {
  // In-memory cache
  final Map<String, CacheEntry> _cache = {};
  static const int _maxCacheSize = 100; // Maximum number of cache entries

  // CacheEntry class to store data with timestamp

  // Helper method to get data from cache or fetch from API
  Future<List<NewsModel>> _getDataWithCache(
      String cacheKey, Future<List<NewsModel>> Function() fetchData) async {
    if (_cache.containsKey(cacheKey) && !_cache[cacheKey]!.isExpired()) {
      print('Returning cached data for key: $cacheKey');
      return _cache[cacheKey]!.data;
    }

    try {
      final data = await fetchData();
      _cache[cacheKey] = CacheEntry(data);
      _limitCacheSize();
      return data;
    } catch (e) {
      print("Error fetching data for key $cacheKey: $e");
      rethrow; // Rethrow the error for better error handling in the UI
    }
  }
  void _limitCacheSize() {
    if (_cache.length > _maxCacheSize) {
      final entriesToRemove = _cache.length - _maxCacheSize;
      final oldestEntries = _cache.entries.toList()
        ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));
      for (var i = 0; i < entriesToRemove; i++) {
        _cache.remove(oldestEntries[i].key);
      }
    }
  }
  Future<List<NewsModel>> getHeadlines({bool forceRefresh = false}) async {
    return _getDataWithCache("headlines_cache", () async {
      Response response = await get(CategoryList.headlin);

      if (response.statusCode == 200) {
        List data = response.body["articles"];
        return data.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load headlines: ${response.statusText}");
      }
    });
  }

  // Method to get news by category with caching
  Future<List<NewsModel>> getCategory({required String category}) async {
    return _getDataWithCache("category_cache_$category", () async {
      Response response = await get(
        "${CategoryList.basurl}$category&${CategoryList.apikey}",
      );

      if (response.statusCode == 200) {
        List data = response.body[Appstring.articals];
        return data.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load category data: ${response.statusText}");
      }
    });
  }

  Future<List<NewsModel>> searchNews({required String query}) async {
    return _getDataWithCache("search_cache_$query", () async {
      Response response = await get(
        "https://newsapi.org/v2/everything?q=$query&${CategoryList.apikey}",
      );

      if (response.statusCode == 200) {
        List data = response.body[Appstring.articals];
        return data.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw Exception(
            "Failed to load search results: ${response.statusText}");
      }
    });
  }
}
