import 'dart:developer';

import 'package:google_ml_kit/google_ml_kit.dart';

class MlLogic {
  // extract text from image
  static Future<String> textRecognition(String filePath) async {
    final InputImage inputImage = InputImage.fromFilePath(filePath);
    final TextRecognizer textRecognizer = new TextRecognizer();

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String textFromImage = recognizedText.text;
    textRecognizer.close();
    return textFromImage;
  }

  // details of image
  static Future<String> imageLabeling(String filePath) async {
    final InputImage inputImage = InputImage.fromFilePath(filePath);
    final ImageLabeler imageLabeler = new ImageLabeler(
        options: new ImageLabelerOptions(confidenceThreshold: 0.1));

    final List<ImageLabel> imageLabels =
        await imageLabeler.processImage(inputImage);
    imageLabeler.close();
    String resultText = "";
    for (var labels in imageLabels) {
      String confidence =
          (double.parse((labels.confidence * 100).toStringAsFixed(2)))
              .toString();
      resultText += "${labels.label} | Confidence: $confidence\n";
    }
    return resultText;
  }
}
