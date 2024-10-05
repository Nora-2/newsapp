import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news/Controller/news_controller.dart';
import 'package:news/View/widgets/list_items.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';
import 'package:news/core/utils/appicons/app_icons.dart';
import 'package:news/core/utils/appimage/app_images.dart'; // Adjust import as needed

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appcolors.transcolor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:  Icon(Appicons.arrow_back),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    cursorColor: appcolors.primarycolor,
                    
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      controller.getSearch(query: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Search term is empty';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      
                      focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15),)),
                     
                      enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText:
                        "Search",
                       hintStyle: TextStyle(color: appcolors.seccolor),
                      
                      prefixIcon: Icon(Appicons.search,
                          color: appcolors.primarycolor),
                    ),
                  ),
                ),
            
                controller.searchResults.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Image.asset(
                            Appimage.search,
                            width: 300.w,
                            height: 380.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListItems(
                          list: controller.searchResults,
                        ),
                      ),
              ],
            ),
          );
        });
  }
}
