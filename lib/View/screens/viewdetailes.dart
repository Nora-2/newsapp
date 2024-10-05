import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Model/news_model.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/core/utils/appstring/app_string.dart';
import 'package:news/core/utils/textstyle/textstyle.dart';
import 'package:news/core/utils/widgets/sizedbox/sizedbox.dart';
class ArticleDetailView extends StatelessWidget {
  final NewsModel article;

  const ArticleDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? Appstring.articleDetail),
        backgroundColor: appcolors.transcolor,
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                     image: CachedNetworkImageProvider(
                            article.urlToImage ?? Appstring.unknown,
                          ),),
                  borderRadius:
                    const  BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            ),
            sized.s16,
            Text(
              article.title ?? Appstring.unknown,
              style:textstyle.boldtext(),
            ),
            sized.s8,
            Text(
              article.content ??Appstring.unknown,
              style:  textstyle.normaltext()
            ),
           sized.s16,
            Text(
              '${article.description ?? Appstring.unknown}',
              style:  textstyle.normaltext()
            ),
          sized.s16,
            Text(
              'Author: ${article.author ??Appstring.unknown}',
              style:   textstyle.author()
            ),
            Text(
              'Published at: ${article.publishedAt ??Appstring.unknown}',
              style:   textstyle.normal()
            ),
          ],
        ),
      ),
    );
  }
}
