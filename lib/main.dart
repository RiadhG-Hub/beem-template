import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/theme.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/router/router.dart';
import 'core/theme/colors.dart';
import 'features/auth/presentation/cubit/user_credentials/user_credentials_cubit.dart';
import 'injectables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final key = dotenv.env['ENCYPT_KEY'] ?? "";
  await EncryptedSharedPreferences.initialize(key);
  configureDependencies();

  await SystemChrome.setPreferredOrientations([
    // Add preferred orientations if needed
    // DeviceOrientation.portraitUp,
  ]);

  await ScreenUtil.ensureScreenSize();

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['DSN'];
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
      options.experimental.replay.sessionSampleRate = 1.0;
      options.experimental.replay.onErrorSampleRate = 1.0;
    },
    appRunner: () => runApp(SentryWidget(child: const MyApp())),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthenticationBloc>()),
        BlocProvider(create: (_) => getIt<UserCredentialsCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return ScreenUtilInit(
            useInheritedMediaQuery: true,
            minTextAdapt: true,
            designSize: _getDesignSize(context),
            builder: (contextMain, child) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: MaterialApp.router(
                  locale: AppLocalizations.supportedLocales.first,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  theme: ThemeData(
                    primaryColor: AppColors.greenTwo,
                    colorScheme: AppColors.colorScheme,
                    fontFamily: 'Segoe_Ui',
                    appBarTheme: appBarTheme,
                    inputDecorationTheme: inputDecorationTheme,
                  ),
                  debugShowCheckedModeBanner: true,
                  routerConfig: router,
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Optimized design size based on screen width
  Size _getDesignSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 400) return const Size(360, 690);
    if (width < 450) return const Size(412, 892);
    if (width < 650) return const Size(480, 892);
    if (width < 700) return const Size(500, 932);
    return const Size(612, 1024); // Tablet or large screen
  }
}
