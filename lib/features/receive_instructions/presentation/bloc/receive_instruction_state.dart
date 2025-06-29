import 'package:momra/features/receive_instructions/data/model/media_response.dart';

sealed class ReceiveInstructionState {
  const ReceiveInstructionState();
}

class ReceiveInstructionInitial extends ReceiveInstructionState {
  const ReceiveInstructionInitial();
}

class ReceiveInstructionLoading extends ReceiveInstructionState {
  const ReceiveInstructionLoading();
}

class ReceiveInstructionSuccess extends ReceiveInstructionState {
  final MediaResponse mediaModel;
  final bool isPrivate;
  final List<MediaList> privateMediaList;
  final List<MediaList> publicMediaList;

  const ReceiveInstructionSuccess(
      {required this.mediaModel,
      required this.isPrivate,
      required this.privateMediaList,
      required this.publicMediaList});
}

class ReceiveInstructionError extends ReceiveInstructionState {
  final String error;
  const ReceiveInstructionError(this.error);
}
