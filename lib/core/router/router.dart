import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/features/auth/presentation/screen/login_page.dart';
import 'package:momra/features/auth/presentation/screen/verify_captcha_page.dart';
import 'package:momra/features/auth/presentation/screen/verify_otp_page.dart';
import 'package:momra/features/receive_instructions/presentation/screen/receive_instruction_page.dart';
import 'package:momra/features/receive_instructions/presentation/widgets/webview_widget.dart';
import 'package:momra/features/send_instructions/presentation/screen/send_instruction_page.dart';
import 'package:momra/features/settings/presentation/pages/settings_view.dart';
import 'package:momra/splash_screen_view.dart' show SplashScreen;

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginPage = '/loginPage';
  static const String sendInstructionPage = '/sendInstructionPage';
  static const String receiveInstructionPage = '/receiveInstructionPage';
  static const String verifyCaptchaPage = '/verifyCaptchaPage';
  static const String verifyOtpPage = '/verifyOtpPage';
  static const String webViewPage = '/webViewPage';
  static const String settingViewPage = '/settings';
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
    GoRoute(
      path: AppRoutes.loginPage,
      name: AppRoutes.loginPage,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.sendInstructionPage,
      name: AppRoutes.sendInstructionPage,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const SendInstructionPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.receiveInstructionPage,
      name: AppRoutes.receiveInstructionPage,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const ReceiveInstructionPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.verifyCaptchaPage,
      name: AppRoutes.verifyCaptchaPage,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const VerifyCaptchaPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.verifyOtpPage,
      name: AppRoutes.verifyOtpPage,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const VerifyOtpPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.webViewPage,
      name: AppRoutes.webViewPage,
      pageBuilder: (context, state) {
        final url = state.uri.queryParameters['url'];
        return _buildPageWithTransition(
          state: state,
          child: WebViewPage(url: url!),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.settingViewPage,
      name: AppRoutes.settingViewPage,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const SettingsPage(),
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
