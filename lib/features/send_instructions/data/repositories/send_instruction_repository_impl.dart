import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/core/error/failures.dart';
import 'package:momra/features/send_instructions/data/data_source/send_instruction_remote_data_source.dart';
import 'package:momra/features/send_instructions/data/model/send_media_mock_model.dart';
import 'package:momra/features/send_instructions/data/model/send_media_request_model.dart';
import 'package:momra/features/send_instructions/domain/repositories/send_instruction_repository.dart';

@injectable
@singleton
class SendInstructionRepositoryImpl implements SendInstructionRepository {
  final SendInstructionDataSource remoteDataSource;

  SendInstructionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, SendMediaResponse>> sendMedia(
      SendMediaRequestModel mediaInfo) async {
    try {
      final response = await remoteDataSource.sendMedia(mediaInfo);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
