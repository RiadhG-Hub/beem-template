class MediaResponse {
  final String errorMessage;
  final int status;
  final List<MediaList> mediaList;

  MediaResponse({
    required this.errorMessage,
    required this.status,
    required this.mediaList,
  });

  factory MediaResponse.fromJson(Map<String, dynamic> json) {
    return MediaResponse(
      errorMessage: json['ErrorMessage'] ?? '',
      status: json['Status'] ?? 0,
      mediaList: (json['MediaList'] as List<dynamic>?)
              ?.map((e) => MediaList.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ErrorMessage': errorMessage,
      'Status': status,
      'MediaList': mediaList.map((e) => e.toJson()).toList(),
    };
  }
}

class MediaList {
  final List<MediaItem> mediaItems;

  MediaList({required this.mediaItems});

  factory MediaList.fromJson(Map<String, dynamic> json) {
    return MediaList(
      mediaItems: (json['MEDIAITEMS'] as List<dynamic>?)
              ?.map((e) => MediaItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MEDIAITEMS': mediaItems.map((e) => e.toJson()).toList(),
    };
  }
}

class MediaItem {
  final String mediaKey;
  final String createdDate;
  final String data;
  final String extension;
  final String dkey;
  final String type;
  final String filename;
  final String? voiceText;

  MediaItem({
    required this.mediaKey,
    required this.createdDate,
    required this.data,
    required this.extension,
    required this.dkey,
    required this.type,
    required this.filename,
    this.voiceText,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      mediaKey: json['MEDIA_KEY'] ?? '',
      createdDate: json['CREATED_DATE'] ?? '',
      data: json['DATA'] ?? '',
      extension: json['EXTENSION'] ?? '',
      dkey: json['DKEY'] ?? '',
      type: json['TYPE'] ?? '',
      filename: json['FILENAME'] ?? '',
      voiceText: json['VOICETEXT'], // nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MEDIA_KEY': mediaKey,
      'CREATED_DATE': createdDate,
      'DATA': data,
      'EXTENSION': extension,
      'DKEY': dkey,
      'TYPE': type,
      'FILENAME': filename,
      if (voiceText != null) 'VOICETEXT': voiceText,
    };
  }
}
