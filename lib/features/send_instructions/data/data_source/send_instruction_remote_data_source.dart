import 'package:injectable/injectable.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/features/send_instructions/data/model/send_media_mock_model.dart';
import 'package:momra/features/send_instructions/data/model/send_media_request_model.dart';

@injectable
@singleton
class SendInstructionDataSource {
  final DioClient _dio;

  SendInstructionDataSource(this._dio);

  Future<SendMediaResponse> sendMedia(
    SendMediaRequestModel mediaInfo,
  ) async {
    try {
      var response = await _dio.client.post(
        '/action/SendMedia',
        data: mediaInfo.toJson(),
      );

      if (response.statusCode == 200) {
      } else {}
      return SendMediaResponse.mock();
    } catch (e) {
      rethrow;
    }
  }
}
