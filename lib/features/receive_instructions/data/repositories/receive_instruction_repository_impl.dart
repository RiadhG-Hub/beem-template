import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/core/error/failures.dart';
import 'package:momra/features/receive_instructions/data/data_source/receive_instruction_remote_data_source.dart';
import 'package:momra/features/receive_instructions/data/model/media_response.dart';
import 'package:momra/features/receive_instructions/domain/repositories/receive_instruction_repository.dart';

@injectable
@singleton
class ReceiveInstructionRepositoryImpl implements ReceiveInstructionRepository {
  final ReceiveInstructionDataSource remoteDataSource;

  ReceiveInstructionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, MediaResponse>> getMedia(
      {required bool instructionsType}) async {
    try {
      final MediaResponse response =
          await remoteDataSource.getMedia(instructionsType: instructionsType);
      if (response.errorMessage.isEmpty) {
        return Right(response);
      } else {
        return Left(ServerFailure(
            message: response.errorMessage.isNotEmpty
                ? response.errorMessage
                : 'Error occurred'));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
