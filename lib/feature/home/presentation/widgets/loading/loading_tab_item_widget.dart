import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors_manager.dart';

class LoadingTabItemWidget extends StatelessWidget {
  const LoadingTabItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: ColorsManager.color6B6B6B, width: 1),
      ),
      child: Container(
        width: 60.w,
        height: 16.h,
        decoration: BoxDecoration(
          color: ColorsManager.colorD9D9D9,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    );
  }
}
