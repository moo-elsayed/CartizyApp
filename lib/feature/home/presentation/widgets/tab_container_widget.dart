import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/feature/home/presentation/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabContainerWidget extends StatelessWidget {
  const TabContainerWidget({
    super.key,
    required this.categories,
    required this.tabController,
    required this.selectedTabIndex,
  });

  final List<CategoryEntity> categories;
  final TabController tabController;
  final int selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: tabController,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) =>
            states.contains(WidgetState.focused) ? null : Colors.transparent,
      ),
      tabAlignment: TabAlignment.start,
      labelPadding: EdgeInsets.zero,
      // onTap: (int index) => setState(() => selectedIndex = index),
      tabs: List.generate(categories.length, (index) {
        var category = categories[index];
        return TabItemWidget(
          category: category,
          needMargin: index != categories.length - 1,
          isSelected: selectedTabIndex == index,
        );
      }),
    );
  }
}
