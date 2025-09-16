import 'package:cartizy_app_nti/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import '../../feature/app_section/app_section.dart';
import '../../feature/auth/view/login_view.dart';
import '../../feature/auth/view/register_view.dart';
import '../../feature/onboarding/onboarding_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onboardingView:
        return CupertinoPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginView:
        // final args = arguments as LoginArgs?;
        return CupertinoPageRoute(builder: (_) => const LoginView());
      case Routes.registerView:
        return CupertinoPageRoute(builder: (_) => const RegisterView());
      case Routes.appSection:
        return CupertinoPageRoute(builder: (_) => const AppSection());
      default:
        return null;
    }
  }
}
