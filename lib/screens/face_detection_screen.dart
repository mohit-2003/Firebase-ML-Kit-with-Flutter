import 'dart:io';

import 'package:flutter/material.dart';

import '../helper.dart';
import '../logic.dart';
import '../widgets/result_box.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({Key? key}) : super(key: key);

  @override
  State<FaceDetectionScreen> createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
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
          resultText = await MlLogic.faceDetector(imgFilePath);
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
