import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiConverter {
  Future<String?> convertAudioToString(File audioFile) async {
    try {
      final String? apiKey = dotenv.env['API_KEY'];
      assert(apiKey != null, "API_KEY is not set in .env file");
      final model = GenerativeModel(
        model: "gemini-2.0-flash",
        apiKey: apiKey!,
      );

      final prompt = TextPart(
          "Transcribe this Arabic audio into accurate, readable text. Do not add punctuation, formatting, or any extra words—just a clean verbatim transcript. ");

      final bytes = await audioFile.readAsBytes();
      final audio = [
        DataPart('audio/wav', bytes)
      ]; // Use correct MIME type for your audio file

      final response = await model.generateContent([
        Content.multi([prompt, ...audio]),
      ]);

      return response.text;
    } catch (e) {
      return null;
    }
  }
}

class GeminiModels {
  static const String geminiFlash = 'gemini-2.0-flash'; // Fast, lightweight
  static const String geminiPro = 'gemini-1.5-pro'; // More capable
}
