import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();

  // Pick multiple images from gallery and return them as JPG
  static Future<List<XFile>> pickImagesFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    List<XFile> jpgFiles = [];

    for (var image in images) {
      try {
        // Convert each image to JPG
        XFile jpgFile = await convertToJpg(image);
        jpgFiles.add(jpgFile);
      } catch (e) {}
    }

    return jpgFiles;
  }

  // Capture an image from the camera
  static Future<List<XFile>> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final XFile jpgFile = await convertToJpg(image);
      return [jpgFile];
    } else {
      return [];
    }
  }

  static Future<List<XFile>> pickDocs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: [
          'XLSX',
          'xlsx',
        ],
        type: FileType.custom);
    if (result != null) {
      final List<XFile> docs = result.files.map((element) {
        return element.xFile;
      }).toList();
      return docs;
    } else {
      return [];
    }
  }

  // Convert an XFile image to JPG
  static Future<XFile> convertToJpg(XFile image) async {
    // Read the image file as bytes
    final bytes = await image.readAsBytes();

    // Decode the image
    img.Image? decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) {
      throw Exception("Failed to decode image");
    }

    // Encode the image as JPG
    final jpgBytes = img.encodeJpg(decodedImage, quality: 85);

    // Save the JPG to a temporary file
    final tempDir = await getTemporaryDirectory();
    final jpgFile =
        File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await jpgFile.writeAsBytes(jpgBytes);

    // Return as XFile
    return XFile(jpgFile.path);
  }
}
