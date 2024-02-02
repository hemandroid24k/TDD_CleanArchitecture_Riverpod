import 'package:go_router/go_router.dart';
import 'package:tdd_clean_architecture_riverpod/core/constants/app_routes.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/presentation/home_screen.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/presentation/login_screen.dart';
class AppRouterConfig{

  GoRouter get appRouterConfig => GoRouter(routes: [
    GoRoute(
      path: AppRoutes().login,
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: AppRoutes().homePage,
      builder: (context, state) => const HomeScreen()
    )
  ], initialLocation: AppRoutes().login);
}