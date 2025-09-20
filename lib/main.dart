import 'package:cartizy_app_nti/core/routing/app_router.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/category_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/entities/product_entity.dart';
import 'package:cartizy_app_nti/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'cartizy_app.dart';
import 'core/helpers/dependency_injection.dart';
import 'core/helpers/hive_helper.dart';
import 'core/helpers/shared_preferences_manager.dart';
import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryEntityAdapter());
  Hive.registerAdapter(ProductEntityAdapter());

  List result = await Future.wait([
    Hive.openBox<CategoryEntity>(HiveHelper.categoriesBox),
    Hive.openBox<ProductEntity>(HiveHelper.productsBox),
    Hive.openBox<ProductEntity>(HiveHelper.cartBox),
    SharedPreferencesManager.getFirstTime(),
    SharedPreferencesManager.getUserLoggedIn(),
  ]);

  bool isFirstTime = result[result.length - 2];
  bool isUserLoggedIn = result.last;

  String initialView = isFirstTime
      ? Routes.onboardingView
      : isUserLoggedIn
      ? Routes.appSection
      : Routes.loginView;

  runApp(CartizyApp(appRouter: AppRouter(), initialView: initialView));
}
