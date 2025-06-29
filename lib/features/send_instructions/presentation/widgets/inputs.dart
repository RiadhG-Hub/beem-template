import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/util/file_record_path_provider.dart';
import 'package:momra/core/util/gemini_converter.dart';
import 'package:momra/core/widgets/common_widgets.dart';
import 'package:momra/features/send_instructions/data/model/send_media_request_model.dart';
import 'package:momra/features/send_instructions/presentation/bloc/collect_instruction_cubit/collect_instruction_cubit_cubit.dart';
import 'package:momra/features/send_instructions/presentation/bloc/send_instruction_bloc/send_instruction_bloc.dart';
import 'package:momra/features/send_instructions/presentation/bloc/send_instruction_bloc/send_instruction_event.dart';
import 'package:momra/features/send_instructions/presentation/bloc/send_instruction_bloc/send_instruction_state.dart';
import 'package:momra/features/send_instructions/presentation/widgets/inputs_maximized_widget.dart';
import 'package:momra/features/send_instructions/presentation/widgets/inputs_minimized_widget.dart';
import 'package:momra/gen/assets.gen.dart';
import 'package:record/record.dart';

class Inputs extends StatefulWidget {
  const Inputs({super.key});

  @override
  State<Inputs> createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  late final CollectInstructionCubit cubit;

  bool _isListening = false;
  bool _isLoading = false;
  bool _isProcessing = false;
  bool _isMinimized = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    cubit = context.read<CollectInstructionCubit>();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    cubit.textController.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (_isListening) return;

    setState(() {
      _errorMessage = '';
      _isListening = true;
    });

    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(
          RecordConfig(
            encoder: AudioEncoder.wav, // or AudioEncoder.wav for lossless STT
            bitRate: 128000, // higher bitrate improves clarity
            sampleRate: 16000, // common for STT engines like Google/Whisper
            numChannels: 1, // mono is sufficient and preferred for STT
            androidConfig: AndroidRecordConfig(
                // Default config is fine unless more customization is needed
                ),
            iosConfig: IosRecordConfig(
              categoryOptions: [
                IosAudioCategoryOption.allowBluetooth,
                IosAudioCategoryOption.defaultToSpeaker,
              ],
              manageAudioSession: true,
            ),
          ),
          path: await FileRecordPathProvider.getFileRecordPath(
            extension: Platform.isAndroid ? "mp4" : "wav",
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'لم يتم منح إذن الوصول للميكروفون';
          _isListening = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل في بدء التسجيل: $e';
        _isListening = false;
      });
    }
  }

  Future<void> _stopRecording() async {
    setState(() {
      _isListening = false;
      _isProcessing = true;
    });

    try {
      final path = await _audioRecorder.stop();
      print("the audion file path is : $path");
      if (path == null) {
        debugPrint('لم يتم العثور على مسار التسجيل');
        return;
      }

      final File audioFile = File(path);
      final gemini = GeminiConverter();
      final candidates = await gemini.convertAudioToString(audioFile);
      final text = candidates?.trim();

      if (text != null && text.isNotEmpty) {
        setState(() {
          cubit.textController.text =
              ('${cubit.textController.text} $text').trim();
        });
      }
      cubit.addVoiceRecord(voiceRecord: audioFile);
    } catch (e) {
      debugPrint('خطأ أثناء إيقاف التسجيل أو معالجة الملف: $e');
      setState(() {
        _errorMessage = 'فشل في معالجة التسجيل الصوتي: $e';
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _toggleRecording() {
    if (_isListening) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void pickImagesFromGallery(BuildContext context) {
    context.read<CollectInstructionCubit>().addPicturesFromGallery();
  }

  void pickImagesFromCamera(BuildContext context) {
    context.read<CollectInstructionCubit>().addPicturesFromCamera();
  }

  void pickDocs(BuildContext context) {
    context.read<CollectInstructionCubit>().addDocs();
  }

  void resetInstruction(BuildContext context) {
    context.read<CollectInstructionCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      height: _isMinimized
          ? (isLandscape ? 0.16.sw : 0.16.sh)
          : (isLandscape ? 0.48.sw : 0.48.sh),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() => _isMinimized = !_isMinimized),
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: AnimatedRotation(
                  turns: _isMinimized ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Assets.svg.spinner.svg(fit: BoxFit.scaleDown),
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
            if (_isProcessing)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: const CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLite,
                  borderRadius: BorderRadius.circular(36.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _isMinimized ? 2.sp : 16.sp,
                    horizontal: 8.sp,
                  ),
                  child:
                      BlocConsumer<SendInstructionBloc, SendInstructionState>(
                          listener: (context, state) {
                    if (state is SendInstructionSuccess) {
                      CommonWidget.getSnackBar(context,
                          message: "تم إرسال الطلب بنجاح");
                      cubit.resetState();
                      _isLoading = false;
                    } else if (state is SendInstructionLoading) {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                  }, builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1000),
                      child: _isMinimized
                          ? InputsMinimizedWidget(
                              isListening: _isListening,
                              isLoading: _isLoading,
                              onTapPickImagesFromGallery: () =>
                                  pickImagesFromGallery(context),
                              onTapPickImagesFromCamera: () =>
                                  pickImagesFromCamera(context),
                              onTapPickDocs: () => pickDocs(context),
                              onTapMic: _toggleRecording,
                              onTapSend: () async {
                                if (cubit.advisorsId.isEmpty) {
                                  CommonWidget.getSnackBar(
                                    context,
                                    message:
                                        "يجب عليك اختيار مستشار واحد على الأقل معاليك",
                                    color: AppColors.red,
                                  );
                                } else {
                                  SendMediaRequestModel
                                      sendMediaRequestMediaModel =
                                      await cubit.convertToModel();
                                  context.read<SendInstructionBloc>().add(
                                        SendInstruction(
                                            sendMediaRequestMediaModel),
                                      );
                                }
                              },
                              onReset: () => resetInstruction(context),
                            )
                          : InputsMaximizedWidget(
                              textController: cubit.textController,
                              isSpeechEnabled: true,
                              isLoading: _isLoading,
                              isMinimized: _isMinimized,
                              isListening: _isListening,
                              onTapPickImagesFromGallery: () =>
                                  pickImagesFromGallery(context),
                              onTapPickImagesFromCamera: () =>
                                  pickImagesFromCamera(context),
                              onTapPickDocs: () => pickDocs(context),
                              onTapMic: _toggleRecording,
                              onTapSend: () async {
                                if (cubit.advisorsId.isEmpty) {
                                  CommonWidget.getSnackBar(
                                    context,
                                    message:
                                        "يجب عليك اختيار مستشار واحد على الأقل معاليك",
                                    color: AppColors.red,
                                  );
                                } else {
                                  SendMediaRequestModel
                                      sendMediaRequestMediaModel =
                                      await cubit.convertToModel();
                                  context.read<SendInstructionBloc>().add(
                                        SendInstruction(
                                            sendMediaRequestMediaModel),
                                      );
                                }
                              },
                              onReset: () => resetInstruction(context),
                            ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
