import 'package:dartz/dartz.dart';
import 'package:momra/core/error/failures.dart';
import 'package:momra/features/send_instructions/data/model/send_media_mock_model.dart';
import 'package:momra/features/send_instructions/data/model/send_media_request_model.dart'
    show SendMediaRequestMediaModel, SendMediaRequestModel;

abstract class SendInstructionRepository {
  Future<Either<Failure, SendMediaResponse>> sendMedia(
      SendMediaRequestModel mediaInfo);
}
