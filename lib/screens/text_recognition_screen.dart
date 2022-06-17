import 'dart:developer';
import 'dart:io';

import 'package:firebase_ml_kit_flutter/helper.dart';
import 'package:firebase_ml_kit_flutter/logic.dart';
import 'package:firebase_ml_kit_flutter/widgets/result_box.dart';
import 'package:flutter/material.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  String resultText = "";
  String imgFilePath = "";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _pickImage(),
                  child: Text(
                      imgFilePath == "" ? "Upload Image" : "Change Image")),
              if (imgFilePath != "")
                new SizedBox(
                  child: new Image.file(new File(imgFilePath)),
                ),
              const SizedBox(height: 20),
              new ResultBox(resultText: resultText)
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Process",
        child: const Icon(Icons.done, size: 28),
        onPressed: () async {
          resultText = await MlLogic.textRecognition(imgFilePath);
          setState(() {});
        },
      ),
    );
  }

  _pickImage() async {
    Helper.pickImage().then((img) => {
          setState(() {
            imgFilePath = img == null ? "" : img.path;
            resultText = "";
          })
        });
  }
}
