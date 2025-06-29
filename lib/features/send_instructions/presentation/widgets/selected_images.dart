import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_state.dart';
import 'package:momra/features/send_instructions/presentation/widgets/image_card.dart';

class SelectedImages extends StatelessWidget {
  const SelectedImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectInstructionCubit, CollectInstructionCubitState>(
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.images.length,
          itemBuilder: (BuildContext context, int index) {
            return ImageCard(state.images[index]);
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
