import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart'
    show AES, AESMode, Encrypted, Encrypter, IV, Key;

String? encryptOld(String plainText, String userLabel) {
  // Ensure userLabel is used correctly for key generation
  // If userLabel is hexadecimal, we need to convert it to bytes
  Uint8List keyBytes;
  if (userLabel.length == 32 && RegExp(r'^[0-9A-Fa-f]+$').hasMatch(userLabel)) {
    // Convert hex string to bytes
    keyBytes = Uint8List.fromList(List.generate(16, (i) {
      return int.parse(userLabel.substring(i * 2, i * 2 + 2), radix: 16);
    }));
  } else if (userLabel.length == 16) {
    keyBytes = Uint8List.fromList(latin1.encode(userLabel));
  } else {
    return null;
  }

  final key = Key(keyBytes);
  final iv = IV.fromLength(16); // Using proper IV for AES
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  // Add prefix character
  String modifiedPlainText = 'X$plainText';

  // Encrypt the plain text
  final encrypted = encrypter.encrypt(modifiedPlainText, iv: iv);

  // Combine IV and encrypted data, then Base64 encode
  final List<int> combined = [...iv.bytes, ...encrypted.bytes];
  String base64 = base64Encode(combined);

  // Replace "+" with "plus"
  String finalString = base64.replaceAll('+', 'plus');

  return finalString;
}

String? decrypt(String encryptedText, String secretKey) {
  // Ensure userLabel is used correctly for key generation
  Uint8List keyBytes;
  if (secretKey.length == 32 && RegExp(r'^[0-9A-Fa-f]+$').hasMatch(secretKey)) {
    // Convert hex string to bytes
    keyBytes = Uint8List.fromList(List.generate(16, (i) {
      return int.parse(secretKey.substring(i * 2, i * 2 + 2), radix: 16);
    }));
  } else if (secretKey.length == 16) {
    keyBytes = Uint8List.fromList(latin1.encode(secretKey));
  } else {
    return null;
  }

  final key = Key(keyBytes);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  try {
    // Replace "plus" back to "+"
    String base64String = encryptedText.replaceAll('plus', '+');

    // Base64 decode the combined data
    Uint8List combined = base64Decode(base64String);

    // Extract IV and encrypted data
    IV iv = IV(combined.sublist(0, 16));
    Encrypted encrypted = Encrypted(combined.sublist(16));

    // Decrypt
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    // Always remove the first character (prefix) from the decrypted text
    // This is necessary for proper handling of Arabic and other non-ASCII text
    // The encrypt function adds 'X' as a prefix, but with different character encodings,
    // checking for 'X' specifically might not work correctly
    if (decrypted.isNotEmpty) {
      return decrypted.substring(1);
    } else {
      return decrypted;
    }
  } catch (e) {
    return null;
  }
}

// Function to try decryption with ECB mode (as in original code)
String? decryptWithECB(String encryptedText, String userLabel) {
  // Ensure userLabel is used correctly for key generation
  Uint8List keyBytes;
  if (userLabel.length == 32 && RegExp(r'^[0-9A-Fa-f]+$').hasMatch(userLabel)) {
    // Convert hex string to bytes
    keyBytes = Uint8List.fromList(List.generate(16, (i) {
      return int.parse(userLabel.substring(i * 2, i * 2 + 2), radix: 16);
    }));
  } else if (userLabel.length == 16) {
    keyBytes = Uint8List.fromList(latin1.encode(userLabel));
  } else {
    return null;
  }

  final key = Key(keyBytes);
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));

  try {
    // Replace "plus" back to "+"
    String base64String = encryptedText.replaceAll('plus', '+');

    // Base64 decode directly (no IV extraction needed for ECB)
    final encrypted = Encrypted.fromBase64(base64String);

    // Decrypt with ECB mode
    final decrypted = encrypter.decrypt(encrypted, iv: IV.fromLength(0));

    // Always remove the first character (prefix) for consistency with CBC mode
    // This is necessary for proper handling of Arabic and other non-ASCII text
    if (decrypted.isNotEmpty) {
      return decrypted.substring(1);
    } else {
      return decrypted;
    }
  } catch (e) {
    return null;
  }
}

// Function to try a basic decryption approach similar to original code
String? decryptOriginalStyle(String encryptedText, String userLabel) {
  // For hex key
  Uint8List keyBytes;
  if (userLabel.length == 32 && RegExp(r'^[0-9A-Fa-f]+$').hasMatch(userLabel)) {
    keyBytes = Uint8List.fromList(List.generate(16, (i) {
      return int.parse(userLabel.substring(i * 2, i * 2 + 2), radix: 16);
    }));
  } else {
    keyBytes = Uint8List.fromList(latin1.encode(userLabel));
  }

  final key = Key(keyBytes);
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));

  try {
    // Replace "plus" back to "+"
    String base64String = encryptedText.replaceAll('plus', '+');

    // Try direct decryption as in original code
    final encrypted = Encrypted.fromBase64(base64String);
    final decrypted = encrypter.decrypt(encrypted, iv: IV.fromLength(0));

    // Always remove the first character (prefix) for consistency
    // This is necessary for proper handling of Arabic and other non-ASCII text
    if (decrypted.isNotEmpty) {
      return decrypted.substring(1);
    } else {
      return decrypted;
    }
  } catch (e) {
    return null;
  }
}

String? decryptOptions(String encryptedText, String userLabel) {
  String? result = decrypt(encryptedText, userLabel);
  if (result != null) {
    return result;
  }

  result = decryptWithECB(encryptedText, userLabel);
  if (result != null) {
    return result;
  }
  result = decryptOriginalStyle(encryptedText, userLabel);
  if (result != null) {
    return result;
  }
  return null;
}

void main() {
  final encryptKey = "76D92340AB1FEC58"; // This is a hex key

  // Try to decrypt the specific problem token
  final problemToken = 'j7JpbusicrkdplusYPcK6Jl6ltfpSdQduZCrXx6P4EhNsc=';

  // Try all decryption methods
  String? decrypted = decryptWithECB(problemToken, encryptKey);
}
