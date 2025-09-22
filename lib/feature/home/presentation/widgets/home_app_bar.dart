import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/shared_preferences_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/confirmation_dialog.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text.rich(
            TextSpan(
              text: 'Hi !,\n',
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'Let’s start your shopping',
                  style: TextStyle(
                    color: Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 12.w,
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(Routes.searchView),
                child: SvgPicture.asset(AppAssets.iconSearch),
              ),
              GestureDetector(
                onTap: () => _showConfirmationDialog(context),
                child: SvgPicture.asset(AppAssets.iconLogout),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) => showCupertinoDialog(
    context: context,
    builder: (_) => ConfirmationDialog(
      delete: false,
      fullText: 'Are you sure you want to log out?',
      onTap: () {
        SharedPreferencesManager.setUserLoggedIn(false);
        context.pushReplacementNamed(Routes.loginView);
      },
      textOkButton: 'Logout',
    ),
  );
}
