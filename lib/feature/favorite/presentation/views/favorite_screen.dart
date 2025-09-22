import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/theming/styles.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'My Favorites',
              style: TextStylesManager.font22RobotoColor212121SemiBold,
            ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}
