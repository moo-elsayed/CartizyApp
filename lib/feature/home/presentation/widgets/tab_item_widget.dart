import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    super.key,
    required this.category,
    this.needMargin = true,
    required this.isSelected,
  });

  final CategoryEntity category;
  final bool needMargin;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(8.r),
      margin: EdgeInsetsGeometry.only(right: needMargin ? 6.w : 0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isSelected
              ? ColorsManager.selectedTabColor
              : ColorsManager.color6B6B6B,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text(
        category.name,
        style: isSelected
            ? TextStylesManager.font14SelectedTabColorBold
            : TextStylesManager.font14color212121Regular,

        textAlign: TextAlign.center,
      ),
    );
  }
}
