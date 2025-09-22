import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors_manager.dart';
import '../../../../core/theming/styles.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.colorEBEBEB,
      surfaceTintColor: ColorsManager.colorEBEBEB,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Icon(Icons.arrow_back, size: 28.r),
      ),
      title: Text(
        'Search',
        style: TextStylesManager.font22RobotoColor212121SemiBold,
      ),
      centerTitle: true,
    );
  }
}
