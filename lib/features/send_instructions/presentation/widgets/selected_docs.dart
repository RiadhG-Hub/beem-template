import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_state.dart';

import 'doc_card.dart';

class SelectedDocs extends StatelessWidget {
  const SelectedDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectInstructionCubit, CollectInstructionCubitState>(
      builder: (context, state) {
        print("state docs");
        print(state.docs.length);
        return GridView.builder(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return DocCard(state.docs[index]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0, // Make items square
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
        );
      },
    );
  }
}
