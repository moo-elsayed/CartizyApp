import 'package:cartizy_app_nti/core/routing/app_router.dart';
import 'package:cartizy_app_nti/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cartizy_app.dart';
import 'core/helpers/shared_preferences_manager.dart';
import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List result = await Future.wait([
    SharedPreferencesManager.getFirstTime(),
    SharedPreferencesManager.getUserLoggedIn(),
  ]);

  bool isFirstTime = result[0];
  bool isUserLoggedIn = result[1];

  String initialView = isFirstTime
      ? Routes.onboardingView
      : isUserLoggedIn
      ? Routes.appSection
      : Routes.loginView;

  Bloc.observer = SimpleBlocObserver();
  runApp(CartizyApp(appRouter: AppRouter(), initialView: initialView));
}
