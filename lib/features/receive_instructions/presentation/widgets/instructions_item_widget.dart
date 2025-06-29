import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momra/core/router/router.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/util/audio_manager.dart';
import 'package:momra/core/util/helper_functions.dart';
import 'package:momra/features/receive_instructions/data/model/media_response.dart';
import 'package:momra/features/receive_instructions/presentation/bloc/cubit/notification_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../gen/assets.gen.dart';

class InstructionsItemWidget extends StatefulWidget {
  final String audioUrl;
  final MediaList media;
  final bool isPrivate;

  const InstructionsItemWidget({
    super.key,
    required this.audioUrl,
    required this.media,
    required this.isPrivate,
  });

  @override
  State<InstructionsItemWidget> createState() => _InstructionsItemWidgetState();
}

class _InstructionsItemWidgetState extends State<InstructionsItemWidget> {
  bool _isTextClicked = false;
  bool _isFilesClicked = false;
  late final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isInitialized = false;
  final List<String> _images = [];
  final List<String> _docs = [];
  File? _audioFile;
  String _speechText = "";
  late final String notificationKey;
  List<String> notification = [];
  String reversed = "";

  @override
  void initState() {
    super.initState();
    _initialize();
    _fetchNotificationList();
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.stop();
        setState(() {
          _isPlaying = false;
        });
      }
    });
    final String fullDate = widget.media.mediaItems[0].createdDate;
    final String trimmed = fullDate.substring(0, fullDate.length - 3);
    final parts = trimmed.split(' ');
    reversed = "${parts[1]} ${parts[0]}";
  }

  Future<void> _initialize() async {
    notificationKey =
        widget.isPrivate ? "privateNotification" : "publicNotification";
    try {
      await _processMedia();
      await _setupAudioPlayer();
      setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  Future<void> _fetchNotificationList() async {
    final NotificationCubit notificationCubit =
        context.read<NotificationCubit>();
    notification = await notificationCubit.loadNotifications(notificationKey);
    if (mounted) setState(() {});
  }

  Future<void> _saveNotification(String id) async {
    final NotificationCubit notificationCubit =
        context.read<NotificationCubit>();

    await notificationCubit.addNotification(notificationKey, id);
    notification = await notificationCubit.loadNotifications(notificationKey);
    if (mounted) setState(() {});
  }

  Future<void> _processMedia() async {
    _images.addAll(widget.media.mediaItems
        .where((item) => item.type == "IMAGE")
        .map((item) => item.data));

    _docs.addAll(widget.media.mediaItems
        .where((item) => item.type == "DOC")
        .map((item) => item.data));

    final voiceItem = widget.media.mediaItems.firstWhere(
      (item) => item.type == "VOICE",
      orElse: () => MediaItem(
        data: '',
        type: '',
        mediaKey: '',
        createdDate: '',
        extension: '',
        dkey: '',
        filename: '',
      ),
    );

    if (voiceItem.data.isNotEmpty) {
      _audioFile = await createMp4FileFromTrimmedBase64(
        input: voiceItem.data,
        filename: const Uuid().v4(),
      );
      _speechText = voiceItem.voiceText ?? "";
    }
  }

  Future<void> _setupAudioPlayer() async {
    print('🔧 Setting up audio player...');
    AudioManager().registerPlayer(_player);

    if (_audioFile != null && await _audioFile!.exists()) {
      try {
        print('🎵 Loading audio file...');

        // Method 1: Try different audio source types
        await _tryMultipleLoadingMethods();
      } catch (e, s) {
        print("❌ All audio loading methods failed: $e\n$s");
      }
    }

    _player.playerStateStream.listen((state) {
      final isPlaying =
          state.playing && state.processingState != ProcessingState.completed;
      if (_isPlaying != isPlaying && mounted) {
        setState(() => _isPlaying = isPlaying);
      }
    });
  }

  Future<void> _tryMultipleLoadingMethods() async {
    if (_audioFile == null) return;

    // Method 1: Try as AudioSource.file
    try {
      print('🔄 Trying AudioSource.file...');
      await _player.setAudioSource(AudioSource.file(_audioFile!.path));
      print('✅ AudioSource.file worked');
      return;
    } catch (e) {
      print('❌ AudioSource.file failed: $e');
    }

    // Method 2: Try setFilePath (your original method)
    try {
      print('🔄 Trying setFilePath...');
      await _player.setFilePath(_audioFile!.path);
      print('✅ setFilePath worked');
      return;
    } catch (e) {
      print('❌ setFilePath failed: $e');
    }

    // Method 3: Try converting WAV to MP3 path (rename and try)
    try {
      print('🔄 Trying with MP3 extension...');
      String mp3Path = _audioFile!.path.replaceAll('.wav', '.mp3');
      File mp3File = await _audioFile!.copy(mp3Path);
      await _player.setFilePath(mp3File.path);
      _audioFile = mp3File; // Update reference
      print('✅ MP3 extension worked');
      return;
    } catch (e) {
      print('❌ MP3 extension failed: $e');
    }

    // Method 4: Try loading as bytes
    try {
      print('🔄 Trying as bytes...');
      final bytes = await _audioFile!.readAsBytes();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_audio.mp3');
      await tempFile.writeAsBytes(bytes);
      await _player.setFilePath(tempFile.path);
      print('✅ Bytes method worked');
      return;
    } catch (e) {
      print('❌ Bytes method failed: $e');
    }

    throw Exception('All loading methods failed');
  }

  void _cleanup() {
    AudioManager().unregisterPlayer(_player);
    _player.dispose();
    _audioFile?.delete();
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    _saveNotification(widget.media.mediaItems[0].mediaKey);
    if (!_isInitialized) return;

    try {
      if (_isPlaying) {
        await _player.stop();
      } else {
        await AudioManager().stopAllExcept(_player);
        await _player.play();
      }
    } catch (e) {
      debugPrint('Audio playback error: $e');
    }
  }

  Widget get _startStopButton => GestureDetector(
        onTap: _isInitialized ? _togglePlay : null,
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: AppColors.primaryGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(
            _isPlaying ? Icons.stop : Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      );

  Widget get _progressSlider => !_isInitialized
      ? const Slider(value: 0, min: 0, max: 1, onChanged: null)
      : StreamBuilder<Duration?>(
          stream: _player.durationStream,
          builder: (context, durationSnapshot) {
            final totalDuration = durationSnapshot.data ?? Duration.zero;
            return StreamBuilder<Duration>(
              stream: _player.positionStream,
              builder: (context, positionSnapshot) {
                final position = positionSnapshot.data ?? Duration.zero;
                return Slider(
                  min: 0.0,
                  max: totalDuration.inMilliseconds.toDouble(),
                  value: position.inMilliseconds
                      .clamp(0, totalDuration.inMilliseconds)
                      .toDouble(),
                  onChanged: (value) {
                    _player.seek(Duration(milliseconds: value.toInt()));
                  },
                );
              },
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.greyLite,
          ),
          width: 1.sw,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "مقطع صوت",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          reversed,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                      width: 0.4.sw,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: _progressSlider,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => _isFilesClicked = !_isFilesClicked);
                        _saveNotification(widget.media.mediaItems[0].mediaKey);
                      },
                      child: Assets.svg.files.svg(
                        fit: BoxFit.scaleDown,
                        height: 26.sp,
                        color: _isFilesClicked
                            ? AppColors.primaryGreen
                            : AppColors.greenThree,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => _isTextClicked = !_isTextClicked);
                        _saveNotification(widget.media.mediaItems[0].mediaKey);
                      },
                      child: Assets.svg.text.svg(
                        fit: BoxFit.scaleDown,
                        height: 26.sp,
                        color: _isTextClicked
                            ? AppColors.primaryGreen
                            : AppColors.greenThree,
                      ),
                    ),
                    _startStopButton,
                  ],
                ),
                if (_isTextClicked) ...[
                  SizedBox(height: 12.sp),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 1.sw,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.sp, vertical: 8.sp),
                      child: Text(
                        _speechText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
                if (_isFilesClicked) ...[
                  SizedBox(height: 12.sp),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 1.sw,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: max(_images.length, 6),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 6,
                          mainAxisExtent: 120.sp,
                        ),
                        itemBuilder: (context, index) {
                          if (index < _images.length) {
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.webViewPage,
                                  queryParameters: {'url': _images[index]},
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.greyLite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Assets.svg.image.svg(
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.greyLite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 1.sw,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: max(_docs.length, 6),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 6,
                          mainAxisExtent: 120.sp,
                        ),
                        itemBuilder: (context, index) {
                          if (index < _docs.length) {
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.webViewPage,
                                  queryParameters: {'url': _docs[index]},
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.greyLite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Assets.svg.doc.svg(
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.greyLite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (!notification.contains(widget.media.mediaItems[0].mediaKey))
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              width: 10,
              height: 10,
            ),
          ),
      ],
    );
  }
}
