import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';

import '../../../../gen/assets.gen.dart';

class DocCard extends StatelessWidget {
  final XFile file;

  const DocCard(this.file, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Center(
              child: Assets.svg.doc.svg(fit: BoxFit.scaleDown, height: 50.sp),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            radius: 16,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.close, size: 18, color: Colors.white),
              onPressed: () {
                context.read<CollectInstructionCubit>().removeDoc(doc: file);
              },
            ),
          ),
        ),
      ],
    );
  }
}
