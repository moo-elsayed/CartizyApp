import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFavouriteIcon extends StatefulWidget {
  const CustomFavouriteIcon({super.key});

  @override
  State<CustomFavouriteIcon> createState() => _CustomFavouriteIconState();
}

class _CustomFavouriteIconState extends State<CustomFavouriteIcon>
    with SingleTickerProviderStateMixin {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 30.w,
      child: IconButton(
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          shape: const CircleBorder(),
          backgroundColor: ColorsManager.white,
          iconSize: 20.r,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashRadius: 24,
        onPressed: () {
          setState(() {
            _isFavourite = !_isFavourite;
          });
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, anim) => ScaleTransition(
            scale: Tween<double>(
              begin: 0.7,
              end: 1.0,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutBack)),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: _isFavourite
              ? const Icon(
                  CupertinoIcons.heart_fill,
                  key: ValueKey("filled"),
                  color: Colors.red,
                )
              : const Icon(
                  CupertinoIcons.heart,
                  key: ValueKey("outlined"),
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}
