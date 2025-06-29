import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_state.dart';
import 'package:momra/l10n/l10n.dart';

import 'advisor_item.dart';

class AdvisorGrid extends StatelessWidget {
  const AdvisorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().user;
    final wrapper = Padding(
      padding: EdgeInsets.only(top: 16.sp, bottom: 8.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            context.l10n.select_all,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 10.sp,
              color: AppColors.grey,
            ),
          ),
          SizedBox(
            width: 30,
            height: 20,
            child: BlocBuilder<CollectInstructionCubit,
                CollectInstructionCubitState>(
              builder: (context, state) {
                return Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => BorderSide(width: 1.0, color: AppColors.black),
                  ),
                  activeColor: AppColors.greenTwo,
                  value: state.selectAll,
                  onChanged: (value) {
                    if (value ?? false) {
                      context
                          .read<CollectInstructionCubit>()
                          .selectAllAdvisor();
                    } else {
                      context
                          .read<CollectInstructionCubit>()
                          .unSelectAllAdvisor();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
    final grid =
        BlocBuilder<CollectInstructionCubit, CollectInstructionCubitState>(
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: user!.usersList!.length,
          itemBuilder: (BuildContext context, int index) {
            return AdvisorItem(
              user.usersList![index].value!,
              user.usersList![index].id!,
              onSelected: (id) {
                if (state.advisorsId.contains(id)) {
                  context
                      .read<CollectInstructionCubit>()
                      .removeAdvisorId(advisorId: id);
                } else {
                  context
                      .read<CollectInstructionCubit>()
                      .addAdvisorId(advisorId: id);

                  print("the advisor id is $id");
                }
              },
              isSelected: state.advisorsId.contains(user.usersList![index].id!),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 6,
            mainAxisExtent: 36.sp,
          ),
        );
      },
    );
    return Column(
      children: [wrapper, grid],
    );
  }
}
