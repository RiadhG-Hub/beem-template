class SendMediaRequest {
  final String fileName;
  final String fileType; // e.g., 'image/png', 'audio/mpeg'
  final String base64Content;
  final String uploadedBy;

  SendMediaRequest({
    required this.fileName,
    required this.fileType,
    required this.base64Content,
    required this.uploadedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileType': fileType,
      'base64Content': base64Content,
      'uploadedBy': uploadedBy,
    };
  }

  static SendMediaRequest mock() => SendMediaRequest(
        fileName: 'test_audio.mp3',
        fileType: 'audio/mpeg',
        base64Content: 'UklGRigAAABXQVZFZm10IBAAAAABAAEA...', // truncated
        uploadedBy: 'user123',
      );
}

class SendMediaResponse {
  final String mediaId;
  final String status;
  final DateTime timestamp;

  SendMediaResponse({
    required this.mediaId,
    required this.status,
    required this.timestamp,
  });

  factory SendMediaResponse.fromJson(Map<String, dynamic> json) {
    return SendMediaResponse(
      mediaId: json['mediaId'] ?? '',
      status: json['status'] ?? 'unknown',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaId': mediaId,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static SendMediaResponse mock() => SendMediaResponse(
        mediaId: 'media789',
        status: 'success',
        timestamp: DateTime.now(),
      );
}
