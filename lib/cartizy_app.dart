import 'package:cartizy_app_nti/core/routing/app_router.dart';
import 'package:cartizy_app_nti/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartizyApp extends StatelessWidget {
  const CartizyApp({
    super.key,
    required this.appRouter,
    required this.initialView,
  });

  final AppRouter appRouter;
  final String initialView;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: ColorsManager.colorEBEBEB),
        initialRoute: initialView,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
