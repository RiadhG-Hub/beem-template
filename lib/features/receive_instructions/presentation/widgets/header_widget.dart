import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/core/router/router.dart';
import 'package:momra/core/util/ecryption_to_arabic.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:momra/injectables.dart';
import 'package:momra/l10n/l10n.dart';

import '../../../../gen/assets.gen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final user = context.read<AuthenticationBloc>().user;
    return SizedBox(
      height: isLandscape ? 0.20.sw : 0.30.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Assets.svg.applicationLogo.svg(
                      fit: BoxFit.scaleDown,
                      width: isLandscape ? 0.4.sh : 0.4.sw,
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final tokenManager = await getIt.getAsync<TokenManager>();
                      await tokenManager.sharedPreferences.clear();
                      context.push(AppRoutes.loginPage);
                    },
                  ),
                ),
              ),
            ],
          ),
          if (user != null)
            Text(
              "${context.l10n.receiver_welcome_desc} ${decryptArabic(user.firstName!)}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 17.sp,
              ),
              textAlign: TextAlign.center,
            ),
          Text(
            context.l10n.receiver_welcome_desc_second,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 17.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
