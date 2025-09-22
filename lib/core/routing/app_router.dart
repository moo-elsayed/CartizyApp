import 'package:cartizy_app_nti/core/helpers/dependency_injection.dart';
import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:cartizy_app_nti/feature/auth/presentation/args/login_args.dart';
import 'package:cartizy_app_nti/feature/auth/presentation/views/welcome_view.dart';
import 'package:cartizy_app_nti/core/entities/product_entity.dart';
import 'package:cartizy_app_nti/feature/home/domain/use_cases/mark_product_as_favorite_or_not.dart';
import 'package:cartizy_app_nti/feature/home/presentation/managers/product_cubit/product_cubit.dart';
import 'package:cartizy_app_nti/feature/home/presentation/views/product_view.dart';
import 'package:cartizy_app_nti/feature/search/domain/use_cases/search_products_use_case.dart';
import 'package:cartizy_app_nti/feature/search/presentation/managers/search_cubit/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/app_section/presentation/views/app_section.dart';
import '../../feature/auth/presentation/views/login_view.dart';
import '../../feature/auth/presentation/views/register_view.dart';
import '../../feature/cart/domain/use_cases/get_products_use_case.dart';
import '../../feature/cart/domain/use_cases/remove_product_use_case.dart';
import '../../feature/cart/presentation/managers/cart_cubit/cart_cubit.dart';
import '../../feature/home/domain/use_cases/add_product_to_cart_use_case.dart';
import '../../feature/onboarding/presentation/views/onboarding_view.dart';
import '../../feature/search/presentation/views/search_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onboardingView:
        return CupertinoPageRoute(builder: (_) => const OnboardingView());
      case Routes.welcomeView:
        return CupertinoPageRoute(builder: (_) => const WelcomeView());
      case Routes.loginView:
        final args = arguments as LoginArgs?;
        return CupertinoPageRoute(builder: (_) => LoginView(loginArgs: args));
      case Routes.registerView:
        return CupertinoPageRoute(builder: (_) => const RegisterView());
      case Routes.appSection:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CartCubit(
              getIt.get<GetProductsUseCase>(),
              getIt.get<RemoveProductUseCase>(),
            ),
            child: const AppSection(),
          ),
        );
      case Routes.productView:
        final args = arguments as ProductEntity;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductCubit(
              getIt.get<AddProductToCartUseCase>(),
              getIt.get<MarkProductAsFavoriteOrNot>(),
            ),
            child: ProductView(product: args),
          ),
        );
      case Routes.searchView:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                SearchCubit(getIt.get<SearchProductsUseCase>()),
            child: const SearchView(),
          ),
        );
      default:
        return null;
    }
  }
}
