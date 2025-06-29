import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<File> createMp4FileFromTrimmedBase64(
    {required String input,
    required String filename,
    String extension = "mp4"}) async {
  if (input.length <= 8) {
    throw ArgumentError('Input must be longer than 8 characters.');
  }

  final trimmed = input.substring(4, input.length - 4);
  final decodedBytes = base64Decode(trimmed);

  // Get app document directory (safe, platform-specific path)
  final dir = await getApplicationDocumentsDirectory();
  final filePath = p.join(dir.path, '$filename.$extension');

  final file = File(filePath);
  await file.writeAsBytes(decodedBytes);

  return file;
}
