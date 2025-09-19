import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/shared_preferences_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
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
          GestureDetector(
            onTap: () => _showConfirmationDialog(context),
            child: Row(
              spacing: 5.w,
              children: [
                SvgPicture.asset(AppAssets.iconLogout),
                Text(
                  'Log out',
                  style: TextStylesManager.font16balooThambi2colorFF4949Regular,
                ),
              ],
            ),
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
