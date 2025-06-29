import 'package:momra/features/send_instructions/data/model/send_media_request_model.dart';

abstract class SendInstructionEvent {
  const SendInstructionEvent();
}

class SendInstruction extends SendInstructionEvent {
  final SendMediaRequestModel instruction;

  const SendInstruction(this.instruction);
}
