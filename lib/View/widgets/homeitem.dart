import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:news/Model/news_model.dart';
import 'package:news/View/screens/viewdetailes.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:news/core/utils/textstyle/textstyle.dart';
import 'package:news/core/utils/widgets/sizedbox/sizedbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homeview extends StatelessWidget {
  const Homeview({Key? key, required this.list}) : super(key: key);
  final List<NewsModel> list;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: list.isEmpty,
      child: ListView.separated(
        itemCount: list.isEmpty ? 5 : list.length, // Show 5 skeleton items when loading
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: list.isNotEmpty ? () {
              Get.to(ArticleDetailView(article: list[index]));
            } : null,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: list.isNotEmpty ? DecorationImage(
                        image: CachedNetworkImageProvider(
                          "${list[index].urlToImage}",
                        ),
                        fit: BoxFit.cover,
                      ) : null,
                    ),
                  ),
                  sized.s10,
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list.isNotEmpty 
                            ? "${list[index].title == Appstring.removed ? Appstring.elonmask : list[index].title}"
                            : "Loading title...",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: textstyle.home(),
                        ),
                        Text(
                          list.isNotEmpty
                            ? "${list[index].content == Appstring.removed ? Appstring.elonmask : list[index].content}"
                            : "Loading content...",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: textstyle.content(),
                        ),
                        sized.s10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                list.isNotEmpty ? list[index].author!.split(',')[0] : "Loading author...",
                                style: textstyle.author()
                              ),
                            ),
                            Text(
                              list.isNotEmpty ? list[index].publishedAt! : "Loading date...",
                              style: TextStyle(color: appcolors.seccolor, fontSize: 16)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}