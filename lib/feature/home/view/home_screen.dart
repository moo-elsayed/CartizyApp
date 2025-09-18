import 'package:cartizy_app_nti/core/helpers/app_assets.dart';
import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/confirmation_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Hi !,\n',
                  style: TextStylesManager.font17balooThambi2BlackMedium,
                  children: [
                    TextSpan(
                      text: 'Let’s start your day',
                      style: TextStylesManager.font18balooThambi2BlackBold,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showConfirmationDialog(context),
                child: Row(
                  spacing: 10.w,
                  children: [
                    SvgPicture.asset(AppAssets.iconLogout),
                    Text(
                      'Log out',
                      style: TextStylesManager
                          .font16balooThambi2colorFF4949Regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Categories",
            style: TextStyle(
              color: Color(0xff212121),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),

          //! getCategories
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showCupertinoDialog(
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
}
