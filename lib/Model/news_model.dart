import 'package:news/core/utils/appimage/app_images.dart';
import 'package:news/core/utils/appstring/app_string.dart';

class NewsModel {
  String? name,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content;

  NewsModel({
    required this.name,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      name: json[Appstring.source][Appstring.name],
      author: json[Appstring.Author]??Appstring.author,
      title: json[Appstring.Title]??Appstring.title,
      description: json[Appstring.Description]??Appstring.description,
      url: json[Appstring.Url],
      urlToImage: json[Appstring.UrlToImage] ?? Appimage.network,
      publishedAt: json[Appstring.PublishedAt]??Appstring.date,
      content: json[Appstring.Content]??Appstring.content,
    );
  }
}
