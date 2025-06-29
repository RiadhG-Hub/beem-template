import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/features/receive_instructions/data/model/media_response.dart';

import 'instructions_item_widget.dart';

class MediaListWidget extends StatelessWidget {
  final List<MediaList> mediaList;
  final bool isPrivate;
  const MediaListWidget(
      {super.key, required this.mediaList, required this.isPrivate});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10.sp),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        return InstructionsItemWidget(
          media: mediaList[index],
          audioUrl: 'https://www.kozco.com/tech/LRMonoPhase4.wav',
          isPrivate: isPrivate,
        );
      },
    );
  }
}
