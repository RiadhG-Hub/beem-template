import 'dart:io';

import 'package:dio/dio.dart';

class SpeechToTextService {
  final Dio _dio = Dio();
  final String _apiKey = '0911a79000a2bae6982710ea817f622d2b414511';
  final String _uploadUrl = 'https://api.assemblyai.com/v2/upload';
  final String _transcriptUrl = 'https://api.assemblyai.com/v2/transcript';

  /// Upload audio file to AssemblyAI
  Future<String> _uploadAudio(File audioFile) async {
    final response = await _dio.post(
      _uploadUrl,
      options: Options(
        headers: {
          'Content-Type': 'audio/wav',
          'Authorization': _apiKey,
          'Transfer-Encoding': 'chunked',
        },
      ),
      data: audioFile.openRead(), // Stream the file
    );

    if (response.statusCode == 200) {
      return response.data['upload_url'];
    } else {
      throw Exception('Failed to upload audio: ${response.statusCode}');
    }
  }

  /// Request transcription
  Future<String> _requestTranscription(String audioUrl) async {
    final response = await _dio.post(
      _transcriptUrl,
      options: Options(
        headers: {
          'Authorization': _apiKey,
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'audio_url': audioUrl,
      },
    );

    if (response.statusCode == 200) {
      return response.data['id'];
    } else {
      throw Exception(
          'Failed to request transcription: ${response.statusCode}');
    }
  }

  /// Check transcription status
  Future<Map<String, dynamic>> _checkTranscriptionStatus(
      String transcriptId) async {
    final response = await _dio.get(
      '$_transcriptUrl/$transcriptId',
      options: Options(
        headers: {
          'Authorization': _apiKey,
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
          'Failed to get transcription result: ${response.statusCode}');
    }
  }

  /// Keep polling until transcription is completed
  Future<String> _waitForTranscription(String transcriptId) async {
    while (true) {
      final result = await _checkTranscriptionStatus(transcriptId);
      final status = result['status'];

      if (status == 'completed') {
        return result['text'];
      } else if (status == 'failed') {
        throw Exception('Transcription failed.');
      } else {
        // Still processing: wait and retry
        await Future.delayed(Duration(seconds: 1));
      }
    }
  }

  /// Public method to handle everything
  Future<String> convert({required File speechVoice}) async {
    try {
      final audioUrl = await _uploadAudio(speechVoice);
      final transcriptId = await _requestTranscription(audioUrl);

      final text = await _waitForTranscription(transcriptId);
      return text;
    } catch (e) {
      throw Exception('Error during transcription: $e');
    }
  }
}
