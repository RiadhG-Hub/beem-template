import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/core/router/router.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:momra/features/send_instructions/presentation/widgets/advisor_grid.dart';
import 'package:momra/features/send_instructions/presentation/widgets/inputs.dart';
import 'package:momra/features/send_instructions/presentation/widgets/selected_docs.dart'
    show SelectedDocs;
import 'package:momra/features/send_instructions/presentation/widgets/selected_images.dart';
import 'package:momra/injectables.dart';
import 'package:momra/l10n/l10n.dart';

import '../../../../gen/assets.gen.dart';

class SendInstructionPage extends StatefulWidget {
  const SendInstructionPage({super.key});

  @override
  State<SendInstructionPage> createState() => _SendInstructionPageState();
}

class _SendInstructionPageState extends State<SendInstructionPage> {
  bool selectAll = false;
  List<String> selectedAdvisors = [];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => _buildPage(context));
  }

  Widget _buildPage(BuildContext context) {
    //final cubit = BlocProvider.of<CollectInstructionCubit>(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SingleChildScrollView(
        child: SizedBox(
          height: isLandscape ? 1.sw : 1.sh,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: isLandscape ? 0.30.sw : 0.30.sh,
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
                                final tokenManager =
                                    await getIt.getAsync<TokenManager>();
                                // await tokenManager.sharedPreferences.clear();
                                await tokenManager.sharedPreferences
                                    .remove(AuthCachedDataSource.key);
                                context.push(AppRoutes.loginPage);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      context.l10n.welcome_desc,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 17.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(36.sp),
                      topEnd: Radius.circular(36.sp),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.sp),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AdvisorGrid(),
                          SelectedImages(),
                          SelectedDocs()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(color: Colors.white, child: Inputs()),
            ],
          ),
        ),
      ),
    );
  }
}
