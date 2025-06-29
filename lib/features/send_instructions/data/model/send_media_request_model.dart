class SendMediaRequestModel {
  final List<SendMediaItemModel> media;
  final bool instructionstype;

  SendMediaRequestModel(this.media, this.instructionstype);

  Map<String, dynamic> toJson() => {
        'instructionstype': instructionstype,
        'Media': media.map((item) => item.toJson()).toList(),
      };
}

class SendMediaItemModel {
  final String data;
  final String type;
  final String destinations;
  final String extension;
  final String voiceText;
  final String fileName;

  SendMediaItemModel({
    required this.data,
    required this.type,
    required this.destinations,
    required this.extension,
    required this.voiceText,
    required this.fileName,
  });

  Map<String, dynamic> toJson() => {
        'data': data,
        'type': type,
        'destinations': destinations,
        'extension': extension,
        'voiceText': voiceText,
        'fileName': fileName,
      };
}
