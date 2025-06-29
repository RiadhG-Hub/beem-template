import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/splash_screen_view.dart' show SplashScreen;

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginPage = '/loginPage';
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splashScreen,
      name: AppRoutes.splashScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const SplashScreen(),
      ),
    ),
  ],
);

CustomTransitionPage _buildPageWithTransition({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const offsetIn = Offset(1.0, 0.0); // Push: enter from right
      const offsetOut = Offset(1.0, 0.0); // Pop: exit to right
      const curve = Curves.easeInOut;

      final inTween = Tween<Offset>(
        begin: offsetIn,
        end: Offset.zero,
      ).chain(CurveTween(curve: curve));

      final outTween = Tween<Offset>(
        begin: Offset.zero,
        end: offsetOut,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(inTween),
        child: SlideTransition(
          position: secondaryAnimation.drive(outTween),
          child: child,
        ),
      );
    },
  );
}
