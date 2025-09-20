import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theming/colors_manager.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onItemTapped,
    required this.labels,
    required this.icons,
  });

  final Function(int index) onItemTapped;
  final List<String> labels;
  final List<String> icons;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Stack(
        children: [
          BottomNavigationBar(
            backgroundColor: ColorsManager.colorEBEBEB,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            selectedItemColor: ColorsManager.selectedTabColor,
            unselectedItemColor: ColorsManager.color5C5C5C,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            items: List.generate(widget.labels.length, (index) {
              var label = widget.labels[index];
              var icon = widget.icons[index];
              return _buildBottomNavigationBarItem(
                label: label,
                iconPath: icon,
              );
            }),
          ),
          Divider(height: 0.1.h, color: ColorsManager.colorC6C6C6),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String iconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: _buildIcon(iconPath: iconPath),
      label: label,
      activeIcon: _buildIcon(iconPath: iconPath, active: true),
    );
  }

  Padding _buildIcon({bool active = false, required String iconPath}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h, top: 4.h),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          active ? ColorsManager.selectedTabColor : ColorsManager.color5C5C5C,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
