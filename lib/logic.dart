import 'dart:developer';

import 'package:firebase_ml_kit_flutter/helper.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MlLogic {
  static Future<String> textRecognition(String filePath) async {
    final InputImage inputImage = InputImage.fromFilePath(filePath);
    final TextRecognizer textRecognizer = new TextRecognizer();
    log("object1");
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String textFromImage = recognizedText.text;
    textRecognizer.close();
    // for (TextBlock block in recognizedText.blocks) {
    //   final String text = block.text;
    //   final List<String> languages = block.recognizedLanguages;

    //   log(languages.toString());
    //   log(text);
    // }
    return textFromImage;
  }
}
