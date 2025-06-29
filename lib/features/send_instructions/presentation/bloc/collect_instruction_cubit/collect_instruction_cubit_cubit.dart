import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/core/util/ecryption_to_arabic.dart';
import 'package:momra/core/util/encryption_helper.dart';
import 'package:momra/core/util/helper_functions.dart';
import 'package:momra/core/util/image_helper.dart';
import 'package:momra/features/auth/data/models/AuthModel.dart';
import 'package:momra/features/send_instructions/data/model/send_media_request_model.dart';

import 'collect_instruction_cubit_state.dart';

// Cubit for managing instruction collection state
@singleton
@injectable
class CollectInstructionCubit extends Cubit<CollectInstructionCubitState> {
  CollectInstructionCubit() : super(CollectInstructionCubitState().init());

  // Data
  List<UserItem> advisors = [];

  List<XFile> images = [];
  List<XFile> docs = [];
  List<String> advisorsId = [];
  File? voiceRecord;
  String speechToText = '';
  bool selectAll = false;
  final SendMediaRequestModel sendMediaRequestMediaModel =
      SendMediaRequestModel([], false);
  final TextEditingController textController = TextEditingController();

  // Text Management
  void appendSpeechText(String text) {
    final current = textController.text;
    textController.text = ('$current $text').trim();
    emit(state.copyWith());
  }

  void clearText() {
    textController.clear();
    emit(state.copyWith());
  }

  // Advisor Selection
  void selectAllAdvisor() {
    advisorsId = advisors.map((advisor) => advisor.id!).toList();
    selectAll = true;
    emit(state.copyWith(selectAll: selectAll, advisorsId: advisorsId));
  }

  void unSelectAllAdvisor() {
    advisorsId = [];
    selectAll = false;
    emit(state.copyWith(selectAll: selectAll, advisorsId: advisorsId));
  }

  void addAdvisorId({required String advisorId}) {
    if (!advisorsId.contains(advisorId)) {
      advisorsId = List<String>.from(advisorsId)..add(advisorId);
      if (advisorsId.length == advisors.length) {
        selectAll = true;
      }
      emit(state.copyWith(advisorsId: advisorsId, selectAll: selectAll));
    }
  }

  void removeAdvisorId({required String advisorId}) {
    if (advisorsId.contains(advisorId)) {
      advisorsId = List<String>.from(advisorsId)..remove(advisorId);
      if (advisorsId.length != advisors.length) {
        selectAll = false;
      }
      emit(state.copyWith(advisorsId: advisorsId, selectAll: selectAll));
    }
  }

  // Image Management
  void addPicturesFromGallery() async {
    final List<XFile> imageResult = await ImageHelper.pickImagesFromGallery();
    _addPicture(imageResult);
  }

  void _addPicture(List<XFile> newImages) {
    if (newImages.isEmpty) return;
    final updatedImages = List<XFile>.from(images)..addAll(newImages);
    images = updatedImages;
    emit(state.copyWith(images: updatedImages));
  }

  void addPicturesFromCamera() async {
    final List<XFile> imageResult = await ImageHelper.pickImageFromCamera();
    _addPicture(imageResult);
  }

  void removePicture({required XFile image}) {
    final updatedImages = List<XFile>.from(images)..remove(image);
    images = updatedImages;
    emit(state.copyWith(images: updatedImages));
  }

  void addDocs() async {
    final List<XFile> docsResult = await ImageHelper.pickDocs();
    if (docsResult.isEmpty) return;
    final updatedDocs = List<XFile>.from(docs)..addAll(docsResult);
    docs = updatedDocs;
    emit(state.copyWith(docs: updatedDocs));
  }

  void removeDoc({required XFile doc}) {
    final updatedDocs = List<XFile>.from(docs)..remove(doc);
    docs = updatedDocs;
    emit(state.copyWith(docs: docs));
  }

  // Voice Management
  void addVoiceRecord({required File voiceRecord}) {
    this.voiceRecord = voiceRecord;
    emit(state.copyWith(voiceRecord: voiceRecord));
  }

  void speechToTextResult({required String speechToText}) {
    this.speechToText = speechToText;
    emit(state.copyWith(speechToText: speechToText));
  }

  void resetState() {
    images = [];
    advisorsId = [];
    voiceRecord = null;
    speechToText = '';
    advisorsId = [];
    selectAll = false;
    textController.clear();
    emit(CollectInstructionCubitState().init());
  }

  // Submission
  void submitInstruction({
    required String instructionText,
    required Function(bool success) onComplete,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      // Implementation for submitting the instruction with all collected data
      // This would typically involve an API call or repository method

      // Simulate success for now
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
      onComplete(true);
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isError: true,
        errorMessage: e.toString(),
      ));
      onComplete(false);
    }
  }

  Future<SendMediaRequestModel> convertToModel() async {
    final encryptKey = "76D92340AB1FEC58";
    List<SendMediaItemModel> mediaItems = [];
    final decryptedDestination = advisorsId.map((element) {
      return decryptOptions(element, encryptKey);
    }).toList();
    final destinationBeforeEncryption = decryptedDestination.join(',');
    final destinations = encrypt(
      decryptedDestination.join(','),
    );

    final voiceText = encrypt(
      speechToText,
    );
    final String prefix = generateRandom4Char();
    final suffix = generateRandom4Char();

// Add images
    for (final image in images) {
      final bytes = await image.readAsBytes();
      final base64Data = "$prefix${base64Encode(bytes)}$suffix";

      mediaItems.add(SendMediaItemModel(
        data: base64Data,
        type: "IMAGE",
        destinations: destinations,
        extension: "jpg",
        voiceText: "",
        fileName: encrypt(image.name),
      ));
    }

// Add voice file
    if (voiceRecord != null) {
      final voiceBytes = await voiceRecord!.readAsBytes();
      final base64Voice = "$prefix${base64Encode(voiceBytes)}$suffix";

      mediaItems.add(SendMediaItemModel(
        data: base64Voice,
        type: "VOICE",
        destinations: destinations,
        extension: "MP4",
        voiceText: encrypt(textController.text),
        fileName: encrypt(voiceRecord!.path), // Empty or encrypt as needed
      ));
    }

    for (final doc in docs) {
      final bytes = await doc.readAsBytes();
      final base64Data = "$prefix${base64Encode(bytes)}$suffix";

      mediaItems.add(SendMediaItemModel(
        data: base64Data,
        type: "DOC",
        destinations: destinations,
        extension: "XLSX",
        voiceText: "",
        fileName: encrypt(doc.name),
      ));
    }

    // if (textController.text.isNotEmpty) {
    //   print("speechToText: ${textController.text}");
    //   final String voiceBytes = base64Encode(utf8.encode(textController.text));
    //   final base64Voice = "$prefix$voiceBytes$suffix";
    //   print(encrypt(textController.text));

    //   mediaItems.add(SendMediaItemModel(
    //     data: encrypt(textController.text),
    //     type: "DOC",
    //     destinations: destinations,
    //     extension: "XLSX",
    //     voiceText: "",
    //     fileName: "", // Empty or encrypt as needed
    //   ));
    // }

// Example if you want to attach instruction text as a document (optional)
    final isPublic = advisorsId.length > 1;
    return SendMediaRequestModel(mediaItems, isPublic);

// Now use `requestModel.toJson()` to send to API
  }
}
