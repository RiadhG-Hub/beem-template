import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/receive_instructions/data/model/media_response.dart';
import 'package:momra/features/receive_instructions/data/repositories/receive_instruction_repository_impl.dart';
import 'package:momra/features/receive_instructions/presentation/bloc/receive_instruction_event.dart';
import 'package:momra/features/receive_instructions/presentation/bloc/receive_instruction_state.dart';

@singleton
@injectable
class ReceiveInstructionBloc
    extends Bloc<ReceiveInstructionEvent, ReceiveInstructionState> {
  List<MediaList> privateMediaList = [];
  List<MediaList> publicMediaList = [];
  final ReceiveInstructionRepositoryImpl receiveInstructionRepositoryImpl;
  ReceiveInstructionBloc(this.receiveInstructionRepositoryImpl)
      : super(ReceiveInstructionInitial()) {
    on<ReceiveInstructionEvent>((event, emit) async {
      if (event is ReceiveInstruction) {
        emit(ReceiveInstructionLoading());
        final result = await receiveInstructionRepositoryImpl.getMedia(
            instructionsType: event.instructionsType);
        result.fold((left) {
          emit(ReceiveInstructionError(left.toString()));
        }, (right) {
          if (event.instructionsType) {
            privateMediaList = right.mediaList;
          } else {
            publicMediaList = right.mediaList;
          }
          emit(ReceiveInstructionSuccess(
            mediaModel: right,
            isPrivate: event.instructionsType,
            publicMediaList: publicMediaList,
            privateMediaList: privateMediaList,
          ));
        });
      }
    });
  }
}
