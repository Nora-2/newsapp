
import 'package:flutter/material.dart';
import 'package:news/core/utils/appcolors/app_colors.dart';

class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: appcolors.primarycolor,
      ),
    );
  }
}
