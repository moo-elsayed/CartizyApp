import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theming/colors_manager.dart';

class LoadingProduct extends StatelessWidget {
  const LoadingProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            width: double.infinity,
            height: 155.h,
            color: ColorsManager.colorD9D9D9,
          ),
        ),
        Container(
          width: 100.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: ColorsManager.colorD9D9D9,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Container(
          width: 60.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: ColorsManager.colorD9D9D9,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }
}
