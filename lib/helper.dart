import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Helper {
  static Future<XFile?> pickImage() async {
    final ImagePicker imagePicker = new ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    return image;
  }
}
