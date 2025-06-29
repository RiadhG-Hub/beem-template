import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/send_instructions/data/repositories/send_instruction_repository_impl.dart';
import 'package:momra/features/send_instructions/presentation/bloc/send_instruction_bloc/send_instruction_event.dart';
import 'package:momra/features/send_instructions/presentation/bloc/send_instruction_bloc/send_instruction_state.dart';

@singleton
@injectable
class SendInstructionBloc
    extends Bloc<SendInstructionEvent, SendInstructionState> {
  final SendInstructionRepositoryImpl sendInstructionRepository;
  SendInstructionBloc(this.sendInstructionRepository)
      : super(SendInstructionInitial()) {
    on<SendInstructionEvent>((event, emit) async {
      if (event is SendInstruction) {
        emit(SendInstructionLoading());
        final result =
            await sendInstructionRepository.sendMedia(event.instruction);
        result.fold((left) {
          emit(SendInstructionError(left.toString()));
        }, (right) {
          emit(SendInstructionSuccess(right));
        });
      }
    });
  }
}
