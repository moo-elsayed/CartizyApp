import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theming/styles.dart';

class SearchPlaceholderWidget extends StatelessWidget {
  const SearchPlaceholderWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.w),
      child: Column(
        children: [
          Gap(140.h),
          Image.asset(AppAssets.searchImage),
          Text(text, style: TextStylesManager.font18color212121Regular),
        ],
      ),
    );
  }
}