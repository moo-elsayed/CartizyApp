import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/widgets/custom_material_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Gap(30.h),
              Image.asset(AppAssets.helloImage),
              Text('Hello!', style: TextStylesManager.font48color212121Medium),
              Gap(137.h),
              CustomMaterialButton(
                onPressed: () {
                  SharedPreferencesManager.setFirstTime(false);
                  context.pushReplacementNamed(
                    Routes.registerView,
                    arguments: true,
                  );
                },
                text: 'Sign Up',
                color: ColorsManager.color212121,
                maxWidth: true,
                textStyle: TextStylesManager.font16WhiteMedium,
                padding: EdgeInsetsGeometry.symmetric(vertical: 15.h),
                borderRadius: BorderRadiusGeometry.circular(8.r),
              ),
              Gap(24.h),
              CustomMaterialButton(
                onPressed: () {
                  SharedPreferencesManager.setFirstTime(false);
                  context.pushReplacementNamed(Routes.loginView);
                },
                text: 'Login',
                maxWidth: true,
                textStyle: TextStylesManager.font16color212121Medium,
                padding: EdgeInsetsGeometry.symmetric(vertical: 15.h),
                borderRadius: BorderRadiusGeometry.circular(8.r),
                side: const BorderSide(color: ColorsManager.color212121),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
