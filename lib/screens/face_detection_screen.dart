import 'dart:io';

import 'package:flutter/material.dart';

import '../helper.dart';
import '../helper/face_paint.dart';
import '../logic.dart';
import 'dart:ui' as ui;

import '../widgets/result_box.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({Key? key}) : super(key: key);

  @override
  State<FaceDetectionScreen> createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  List<Rect> rect = [];
  String resultText = "";
  String imgFilePath = "";
  ui.Image? imgFile;
  bool isImageLoaded = false;
  bool isFaceDetected = false;
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
              if (imgFilePath != "" && imgFile == null)
                new SizedBox(
                  child: new Image.file(new File(imgFilePath)),
                ),
              const SizedBox(height: 20),
              if (imgFile != null)
                FittedBox(
                  child: SizedBox(
                    width: imgFile?.width.toDouble(),
                    height: imgFile?.height.toDouble(),
                    child: CustomPaint(
                      painter: FacePainter(rectList: rect, imageFile: imgFile!),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (imgFile != null)
                new ResultBox(
                    resultText:
                        "${(rect.isEmpty) ? "No" : rect.length} face detected")
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Process",
        child: const Icon(Icons.done, size: 28),
        onPressed: () async {
          rect = await MlLogic.faceDetector(imgFilePath);
          _loadImage(File(imgFilePath));
          setState(() {});
        },
      ),
    );
  }

  _pickImage() async {
    Helper.pickImage().then((img) => {
          setState(() {
            imgFilePath = img == null ? "" : img.path;
            imgFile = null;
          })
        });
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) => setState(() {
          imgFile = value;
        }));
  }
}
