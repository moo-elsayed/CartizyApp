import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../../core/theming/styles.dart';

class FavoritesPlaceholder extends StatelessWidget {
  const FavoritesPlaceholder({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          Gap(188.h),
          Icon(
            CupertinoIcons.heart,
            size: 120.r,
            color: ColorsManager.color2F2F2F,
          ),
          Gap(8.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStylesManager.font18color212121Regular,
          ),
        ],
      ),
    );
  }
}
