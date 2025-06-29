import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class PKICipherAES {
  final Uint8List key;

  PKICipherAES(this.key);

  Uint8List decrypt(Uint8List encryptedData) {
    final iv =
        Uint8List.fromList(List.filled(16, 0)); // AES block size = 16 bytes

    final cbc = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(key), iv));

    final padding = PKCS7Padding();
    final paddedBlockCipher = PaddedBlockCipherImpl(padding, cbc)
      ..init(
          false,
          PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
            ParametersWithIV(KeyParameter(key), iv),
            null,
          ));

    return paddedBlockCipher.process(encryptedData);
  }

  Uint8List encrypt(Uint8List inputData) {
    final iv =
        Uint8List.fromList(List.filled(16, 0)); // AES block size = 16 bytes

    final cbc = CBCBlockCipher(AESEngine())
      ..init(true, ParametersWithIV(KeyParameter(key), iv));

    final padding = PKCS7Padding();
    final paddedBlockCipher = PaddedBlockCipherImpl(padding, cbc)
      ..init(
          true,
          PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
            ParametersWithIV(KeyParameter(key), iv),
            null,
          ));

    return paddedBlockCipher.process(inputData);
  }
}

String decryptArabic(String encryptedValue) {
  try {
    const String userLabel = "76D92340AB1FEC58";
    final String base64Value = encryptedValue.replaceAll('plus', '+');
    final Uint8List encryptedBytes = base64.decode(base64Value);
    final Uint8List keyBytes = Uint8List.fromList(utf8.encode(userLabel));

    final aes = PKICipherAES(keyBytes);
    final Uint8List decryptedBytes = aes.decrypt(encryptedBytes);

    final String decryptedString = utf8.decode(decryptedBytes);
    return decryptedString.length > 1 ? decryptedString.substring(1) : '';
  } catch (e) {
    return encryptedValue;
  }
}

String encrypt(String value) {
  try {
    final String userLabel = "76D92340AB1FEC58";

    // Generate a random lowercase character from 'a' to 'y'
    final rand = Random();
    final String prefixChar =
        String.fromCharCode('a'.codeUnitAt(0) + rand.nextInt(25));

    // Prepend it to the input value
    final String prefixedValue = prefixChar + value;

    // ✅ Use UTF-8 encoding to support Arabic
    final Uint8List inputBytes = utf8.encode(prefixedValue);
    final Uint8List keyBytes = utf8.encode(userLabel);

    // Encrypt using AES
    final aes = PKICipherAES(keyBytes);
    final Uint8List encryptedBytes = aes.encrypt(inputBytes);

    // Encode to Base64 and replace "+" with "plus"
    final String encryptedBase64 =
        base64.encode(encryptedBytes).replaceAll('+', 'plus');

    return encryptedBase64;
  } catch (e) {}

  return value;
}

String encryptArabic(String plainText) {
  try {
    const String userLabel = "76D92340AB1FEC58";
    final Uint8List keyBytes = Uint8List.fromList(utf8.encode(userLabel));

    // Optional: Add a leading character to match the decryption trimming logic
    final String input = ' $plainText';

    final Uint8List plainBytes = Uint8List.fromList(utf8.encode(input));
    final aes = PKICipherAES(keyBytes);
    final Uint8List encryptedBytes = aes.encrypt(plainBytes);

    String base64Encoded = base64.encode(encryptedBytes);
    return base64Encoded.replaceAll('+', 'plus');
  } catch (e) {
    return plainText;
  }
}

void main() {
  final input = "zTidoGXfaML43KLp/HpSttpplusplusoc/RhnWLjPibAAAM8Y=";

  final decrypted = decryptArabic(input);

  final encrypted = encryptArabic(decrypted.trim());
}
