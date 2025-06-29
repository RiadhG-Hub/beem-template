import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileRecordPathProvider {
  static Future<String> getFileRecordPath({String extension = "wav"}) async {
    // Get the app's documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a folder if it doesn't exist
    final myFolder = Directory('${directory.path}/momra');
    if (!await myFolder.exists()) {
      await myFolder.create(recursive: true);
    }

    // Define file path
    final filePath = '${myFolder.path}/record.$extension';
    return filePath;
  }

  static Future<String> getFileRecordPathForGemini() async {
    // Get the app's documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a folder if it doesn't exist
    final myFolder = Directory('${directory.path}/momra');
    if (!await myFolder.exists()) {
      await myFolder.create(recursive: true);
    }

    // Define file path
    final filePath = '${myFolder.path}/record.mp4';
    return filePath;
  }
}
