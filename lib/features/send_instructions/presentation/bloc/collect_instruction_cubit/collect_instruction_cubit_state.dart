import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CollectInstructionCubitState extends Equatable {
  final List<XFile> images;
  final List<XFile> docs;
  final List<String> advisorsId;
  final File? voiceRecord;
  final String speechToText;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isError;
  final String errorMessage;
  final bool selectAll;

  const CollectInstructionCubitState(
      {this.images = const [],
      this.docs = const [],
      this.advisorsId = const [],
      this.voiceRecord,
      this.speechToText = '',
      this.isSubmitting = false,
      this.isSuccess = false,
      this.isError = false,
      this.errorMessage = '',
      this.selectAll = false});

  CollectInstructionCubitState init() {
    return const CollectInstructionCubitState();
  }

  CollectInstructionCubitState copyWith({
    List<XFile>? images,
    List<XFile>? docs,
    List<String>? advisorsId,
    File? voiceRecord,
    String? speechToText,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    bool? selectAll,
  }) {
    return CollectInstructionCubitState(
        images: images ?? this.images,
        docs: docs ?? this.docs,
        advisorsId: advisorsId ?? this.advisorsId,
        voiceRecord: voiceRecord ?? this.voiceRecord,
        speechToText: speechToText ?? this.speechToText,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage,
        selectAll: selectAll ?? this.selectAll);
  }

  @override
  List<Object?> get props => [
        images,
        docs,
        advisorsId,
        voiceRecord,
        speechToText,
        isSubmitting,
        isSuccess,
        isError,
        errorMessage,
        selectAll
      ];
}
