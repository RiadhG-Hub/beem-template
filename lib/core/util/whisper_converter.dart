import 'dart:io';

import 'package:flutter/services.dart';
//import 'package:whisper_ggml/whisper_ggml.dart';

//class WhisperConverter {
//  final controller = WhisperController();
//  final model = WhisperModel.tiny;
//  Future<String?> convertAudioToString(File audioFile) async {
//    final bytesBase = await rootBundle.load('assets/whisper/ggml-tiny.bin');
//
//    final modelPathBase = await controller.getPath(model);
//    final fileBase = File(modelPathBase);
//    await fileBase.writeAsBytes(bytesBase.buffer
//        .asUint8List(bytesBase.offsetInBytes, bytesBase.lengthInBytes));
//
//    final result = await controller.transcribe(
//      model: model,
//
//      /// Selected WhisperModel
//      audioPath: audioFile.path,
//
//      /// Path to .wav file
//      lang: 'ar',
//
//      /// Language to transcribe
//    );
//    if (result?.transcription.text != null) {
//      print(result!.transcription.text);
//      return result.transcription.text;
//    } else {
//      print('Transcription failed or returned null');
//      return null;
//    }
//  }
//}
//