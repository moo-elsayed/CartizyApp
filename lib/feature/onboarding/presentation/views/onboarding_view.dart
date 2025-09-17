import 'package:cartizy_app_nti/core/helpers/extentions.dart';
import 'package:cartizy_app_nti/core/helpers/shared_preferences_manager.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:cartizy_app_nti/core/theming/styles.dart';
import 'package:cartizy_app_nti/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/models/onborading_data_model.dart';
import '../widgets/custom_animated_widget.dart';
import 'package:gap/gap.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  List<OnboardingDataModel> onboardingList = OnboardingDataModel.onboardingList;
  int index = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.colorEBEBEB,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(60.h),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, index) => CustomAnimatedWidget(
                    delay: index,
                    index: index,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(
                        onboardingList[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  itemCount: onboardingList.length,
                ),
              ),
              Gap(16.h),
              SmoothPageIndicator(
                controller: _controller,
                count: onboardingList.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  dotColor: ColorsManager.colorAAA198,
                  activeDotColor: ColorsManager.color212121,
                  spacing: 6.w
                ),
              ),
              Gap(56.h),
              CustomAnimatedWidget(
                delay: (index + 1) * 100,
                index: index,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  width: double.infinity,
                  child: Column(
                    spacing: 8.h,
                    children: [
                      Text(
                        onboardingList[index].title,
                        style: TextStylesManager.font22color1F1F1FBold,
                      ),
                      Text(
                        onboardingList[index].description,
                        style: TextStylesManager.font18color5C5C5CRegular,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Gap(58.h),
              CustomMaterialButton(
                onPressed: () {
                  if (index < onboardingList.length - 1) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  } else {
                    SharedPreferencesManager.setFirstTime(false);
                    context.pushReplacementNamed(Routes.loginView);
                  }
                },
                text: index < onboardingList.length - 1
                    ? 'Next'
                    : 'Get Started',
                color: const Color(0xff212121),
                maxWidth: true,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                textStyle: TextStylesManager.font16WhiteMedium,
                borderRadius: BorderRadiusGeometry.circular(8.r),
              ),
              Gap(125.h),
            ],
          ),
        ),
      ),
    );
  }
}
