import 'package:momra/features/send_instructions/data/model/send_media_mock_model.dart';

abstract class SendInstructionState {
  const SendInstructionState();
}

class SendInstructionInitial extends SendInstructionState {
  const SendInstructionInitial();
}

class SendInstructionLoading extends SendInstructionState {
  const SendInstructionLoading();
}

class SendInstructionSuccess extends SendInstructionState {
  final SendMediaResponse data;
  const SendInstructionSuccess(this.data);
}

class SendInstructionError extends SendInstructionState {
  final String error;
  const SendInstructionError(this.error);
}
