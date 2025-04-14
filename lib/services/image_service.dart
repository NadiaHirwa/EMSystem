import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

class ImageService {
  static Future<String> saveImageLocally(File imageFile) async {
    try {
      // Get the application documents directory
      final Directory appDir = await path_provider.getApplicationDocumentsDirectory();
      final String appDirPath = appDir.path;

      // Create an images directory if it doesn't exist
      final Directory imageDir = Directory('$appDirPath/images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      // Generate a unique filename using timestamp
      final String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';
      
      // Copy the file to our app's local storage
      final File localImage = await imageFile.copy('${imageDir.path}/$fileName');
      
      // Return the local path
      return localImage.path;
    } catch (e) {
      print('Error saving image locally: $e');
      return '';
    }
  }

  static Future<File?> getLocalImage(String imagePath) async {
    try {
      final File file = File(imagePath);
      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      print('Error getting local image: $e');
      return null;
    }
  }
} 