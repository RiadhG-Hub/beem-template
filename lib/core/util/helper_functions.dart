import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

String calculateBottleAge(int productionYear) {
  int currentYear = DateTime.now().year;
  int age = currentYear - productionYear;
  return "$age Year${age > 1 ? 's' : ''} old";
}

String basicAuth({required String userName, required String password}) {
  //'Basic ${generateRandom3Char()}${base64.encode(utf8.encode('$userName:$password'))}${generateRandom3Char()}';
  final basic = base64.encode(utf8.encode('$userName:$password'));
  return basic;
}

String generateRandom3Char() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random();
  return List.generate(3, (_) => chars[rand.nextInt(chars.length)]).join();
}

String generateRandom4Char() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random();
  return List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
}

Future<File> createMp4FileFromTrimmedBase64(
    {required String input,
    required String filename,
    String? extension = 'wav'}) async {
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
