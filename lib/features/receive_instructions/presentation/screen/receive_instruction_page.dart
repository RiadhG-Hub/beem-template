import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/widgets/custom_button.dart'
    show CustomButtonWithNotif;
import 'package:momra/features/receive_instructions/presentation/bloc/cubit/notification_cubit.dart';
import 'package:momra/features/receive_instructions/presentation/bloc/receive_instruction_bloc.dart';
import 'package:momra/features/receive_instructions/presentation/bloc/receive_instruction_event.dart';
import 'package:momra/features/receive_instructions/presentation/bloc/receive_instruction_state.dart';
import 'package:momra/features/receive_instructions/presentation/widgets/header_widget.dart';
import 'package:momra/features/receive_instructions/presentation/widgets/media_list_widget.dart';
import 'package:momra/l10n/l10n.dart';

import '../../../../gen/assets.gen.dart';

class ReceiveInstructionPage extends StatefulWidget {
  const ReceiveInstructionPage({super.key});

  @override
  State<ReceiveInstructionPage> createState() => _ReceiveInstructionPageState();
}

class _ReceiveInstructionPageState extends State<ReceiveInstructionPage> {
  int clickedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      context.read<ReceiveInstructionBloc>().add(ReceiveInstruction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderWidget(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(36.sp),
                  topEnd: Radius.circular(36.sp),
                ),
              ),
              child:
                  BlocBuilder<ReceiveInstructionBloc, ReceiveInstructionState>(
                builder: (context, state) {
                  switch (state) {
                    case ReceiveInstructionLoading():
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGreen,
                        ),
                      );

                    case ReceiveInstructionSuccess():
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 16.sp, bottom: 8.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButtonWithNotif(
                                      onPressed: () {
                                        context
                                            .read<ReceiveInstructionBloc>()
                                            .add(ReceiveInstruction(false));
                                        setState(() {
                                          clickedIndex =
                                              0; // first button clicked
                                        });
                                      },
                                      icon: Assets.svg.specialInstructions.svg(
                                        fit: BoxFit.scaleDown,
                                        height: 26.sp,
                                        color: clickedIndex == 1
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      text: context.l10n.special_instructions,
                                      notifCount: state.publicMediaList.length,
                                      isClicked: clickedIndex == 0,
                                    ),
                                    BlocBuilder<NotificationCubit,
                                        NotificationState>(
                                      builder: (context, cubitState) {
                                        return CustomButtonWithNotif(
                                          onPressed: () {
                                            context
                                                .read<ReceiveInstructionBloc>()
                                                .add(ReceiveInstruction(true));
                                            setState(() {
                                              clickedIndex =
                                                  1; // first button clicked
                                            });
                                          },
                                          icon: Assets.svg.generalInstructions
                                              .svg(
                                            fit: BoxFit.scaleDown,
                                            height: 26.sp,
                                            color: clickedIndex == 0
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          text:
                                              context.l10n.general_instructions,
                                          notifCount: state.privateMediaList
                                              .where((element) {
                                            return !cubitState.notifications
                                                .contains(element
                                                    .mediaItems[0].mediaKey);
                                          }).length,
                                          isClicked: clickedIndex == 1,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (state.mediaModel.mediaList.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Text("لا توجد تعليمات حتى الآن"),
                                )
                              else
                                MediaListWidget(
                                  mediaList: state.mediaModel.mediaList,
                                  isPrivate: state.isPrivate,
                                )
                            ],
                          ),
                        ),
                      );

                    case ReceiveInstructionError():
                      return Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Error: ${state.error}"),
                          MaterialButton(
                            onPressed: () {
                              context
                                  .read<ReceiveInstructionBloc>()
                                  .add(ReceiveInstruction(true));
                            },
                            child: const Text("retry"),
                          )
                        ],
                      ));

                    default:
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGreen,
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
