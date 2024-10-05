import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Model/news_model.dart';
import 'package:news/View/screens/viewdetailes.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:news/core/utils/textstyle/textstyle.dart';
import 'package:news/core/utils/widgets/sizedbox/sizedbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListItems extends StatelessWidget {
  const ListItems({Key? key, required this.list}) : super(key: key);

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
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 160,
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
                  ),
                  sized.w10,
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.isNotEmpty
                              ? "${list[index].title == Appstring.removed ? Appstring.elonmask : list[index].title}"
                              : "Loading title...",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textstyle.large(),
                          ),
                          Expanded(
                            child: Text(
                              list.isNotEmpty
                                ? "${list[index].content == Appstring.removed ? Appstring.elonmask : list[index].content}"
                                : "Loading content...",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: textstyle.content(),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    list.isNotEmpty ? list[index].author!.split(',')[0] : "Loading author...",
                                    overflow: TextOverflow.ellipsis,
                                    style: textstyle.author(),
                                  ),
                                ),
                                Text(
                                  list.isNotEmpty ? list[index].publishedAt!.substring(2, 10) : "Loading date...",
                                  style: TextStyle(color: appcolors.seccolor, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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