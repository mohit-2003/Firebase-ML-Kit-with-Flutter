import 'dart:developer' as dev;
import 'package:flutter/material.dart';
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

  // face detector
  static Future<List<Rect>> faceDetector(String filePath) async {
    final InputImage inputImage = InputImage.fromFilePath(filePath);
    final FaceDetector faceDetector =
        new FaceDetector(options: new FaceDetectorOptions());

    final List<Face> faceList = await faceDetector.processImage(inputImage);
    List<Rect> rectList = [];
    for (Face face in faceList) {
      final Rect boundingBox = face.boundingBox;
      rectList.add(boundingBox);
    }
    faceDetector.close();

    return rectList;
  }

  // language identifier
  static Future<String> languageIdentifier(String text) async {
    final LanguageIdentifier languageIdentifier =
        new LanguageIdentifier(confidenceThreshold: 0.1);

    String resultText = await languageIdentifier.identifyLanguage(text);
    List<IdentifiedLanguage> possibleLanguages =
        await languageIdentifier.identifyPossibleLanguages(text);
    languageIdentifier.close();

    if (possibleLanguages.length == 1) return resultText;
    resultText += "\nOther possible languages: 👇\n";
    for (var i = 1; i < possibleLanguages.length; i++) {
      var languages = possibleLanguages[i];
      String confidence =
          (double.parse((languages.confidence * 100).toStringAsFixed(2)))
              .toString();

      resultText += "${languages.languageTag} | Confidence: $confidence\n";
    }
    return resultText;
  }

  // language translator TODO
  static Future<String> languageTranslator(String text) async {
    final LanguageIdentifier languageIdentifier =
        new LanguageIdentifier(confidenceThreshold: 0.1);

    String resultText = await languageIdentifier.identifyLanguage(text);
    List<IdentifiedLanguage> possibleLanguages =
        await languageIdentifier.identifyPossibleLanguages(text);
    languageIdentifier.close();

    if (possibleLanguages.length == 1) return resultText;
    resultText += "\nOther possible languages: 👇\n";
    for (var i = 1; i < possibleLanguages.length; i++) {
      var languages = possibleLanguages[i];
      String confidence =
          (double.parse((languages.confidence * 100).toStringAsFixed(2)))
              .toString();

      resultText += "${languages.languageTag} | Confidence: $confidence\n";
    }
    return resultText;
  }

  // barcode scanner
  static Future<String> barcodeScanner(String filePath) async {
    final InputImage inputImage = InputImage.fromFilePath(filePath);

    final barcodeFormats = [BarcodeFormat.all];
    final scanner = BarcodeScanner(formats: barcodeFormats);
    final List<Barcode> barcodeList = await scanner.processImage(inputImage);

    scanner.close();
    String resultText = "";
    for (Barcode barcode in barcodeList) {
      // final type = barcode.type;
      final rawValue = barcode.rawValue;
      // final displayValue = barcode.displayValue;

      // final value = barcode.value;

      resultText += "Raw value : ${rawValue.toString()}";
    }
    return resultText;
  }

  // translator
  static Future<String> translate(String text) async {
    const TranslateLanguage sourceLanguage = TranslateLanguage.english;
    const TranslateLanguage targetLanguage = TranslateLanguage.hindi;

    final OnDeviceTranslator onDeviceTranslator = new OnDeviceTranslator(
        sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);

    String resultText = await onDeviceTranslator.translateText(text);
    return resultText;
  }
}
