import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/theming/styles.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
    required this.description,
    required this.image,
  });

  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(150.h),
          Image.asset(image),
          Gap(16.h),
          Text(
              description,
              textAlign: TextAlign.center,
              style: TextStylesManager.font18color212121Regular
          ),
        ],
      ),
    );
  }
}