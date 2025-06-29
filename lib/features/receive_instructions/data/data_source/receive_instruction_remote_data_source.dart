import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/core/db_config/dio_interceptor.dart';
import 'package:momra/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:momra/features/receive_instructions/data/model/media_response.dart';

@injectable
@singleton
class ReceiveInstructionDataSource {
  final Dio _dio;

  ReceiveInstructionDataSource(DioClient dioClient) : _dio = dioClient.client;

  Future<MediaResponse> getMedia({required bool instructionsType}) async {
    try {
      final response = await _dio.get(
        '/action/GetMedia',
        options: Options(
          headers: {
            'Instructionstype': instructionsType,
          },
        ),
      );
      final result = MediaResponse.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data,
      );
      if (result.errorMessage.isEmpty) {
        return result;
      } else {
        throw result.errorMessage;
      }
    } catch (e) {
      if (e is String) {
        rethrow;
      } else {
        throw AuthDataSource.unknownIssue;
      }
    }
  }
}
