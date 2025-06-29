import "package:dartz/dartz.dart";
import "package:momra/core/error/failures.dart";
import "package:momra/features/receive_instructions/data/model/media_response.dart";

abstract class ReceiveInstructionRepository {
  Future<Either<Failure, MediaResponse>> getMedia(
      {required bool instructionsType});
}
