import 'dart:io';
import 'package:firebase_ml_kit_flutter/helper/operation_enum.dart';
import 'package:firebase_ml_kit_flutter/logic.dart';
import 'package:flutter/material.dart';
import '../helper.dart';
import 'dart:ui' as ui;
import '../helper/face_paint.dart';
import '../widgets/result_box.dart';

class ResultScreen extends StatefulWidget {
  final Operations operation;
  const ResultScreen({Key? key, required this.operation}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _selectedImgPath = "";
  ui.Image? _resultImg;
  String _resultText = "";
  final controller = new TextEditingController();
  List<Rect> rect = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: getContent(),
      floatingActionButton: new FloatingActionButton(
          tooltip: "Process",
          child: const Icon(Icons.done, size: 28),
          onPressed: () async {
            await onSubmit(widget.operation);
            setState(() {});
          }),
    );
  }

  Center getContent() {
    return new Center(
      child: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.operation != Operations.LANGUAGE_IDENTIFICATION &&
                widget.operation != Operations.TRANSLATE)
              ElevatedButton(
                  onPressed: () => _pickImage(),
                  child: Text(_selectedImgPath == ""
                      ? "Upload Image"
                      : "Change Image")),
            if (_selectedImgPath != "" &&
                _resultImg == null &&
                widget.operation != Operations.LANGUAGE_IDENTIFICATION)
              new SizedBox(
                child: new Image.file(new File(_selectedImgPath)),
              )
            else if (widget.operation == Operations.LANGUAGE_IDENTIFICATION ||
                widget.operation == Operations.TRANSLATE)
              new Container(
                margin: const EdgeInsets.all(8),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  controller: controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(hintText: "Enter text"),
                ),
              ),
            const SizedBox(height: 20),
            if (_resultImg != null)
              FittedBox(
                child: SizedBox(
                  width: _resultImg?.width.toDouble(),
                  height: _resultImg?.height.toDouble(),
                  child: CustomPaint(
                    painter:
                        FacePainter(rectList: rect, imageFile: _resultImg!),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            new ResultBox(
                resultText: _resultImg == null
                    ? _resultText
                    : "${(rect.isEmpty) ? "No" : rect.length} face detected")
          ],
        ),
      ),
    );
  }

  _pickImage() async {
    Helper.pickImage().then((img) => {
          setState(() {
            _selectedImgPath = img == null ? "" : img.path;
            _resultImg = null;
          })
        });
  }

  onSubmit(Operations operation) async {
    switch (operation) {
      case Operations.TEXT_RECOGNITION:
        _resultText = await MlLogic.textRecognition(_selectedImgPath);
        break;
      case Operations.IMAGE_LABELING:
        _resultText = await MlLogic.imageLabeling(_selectedImgPath);
        break;
      case Operations.BARCODE_SCANNING:
        _resultText = await MlLogic.barcodeScanner(_selectedImgPath);
        break;
      case Operations.LANGUAGE_IDENTIFICATION:
        _resultText = await MlLogic.languageIdentifier(controller.text);
        break;
      case Operations.FACE_DETECTION:
        rect = await MlLogic.faceDetector(_selectedImgPath);
        _loadImage(File(_selectedImgPath));
        break;
      case Operations.TRANSLATE:
        _resultText = await MlLogic.translate(controller.text);
        break;
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) => setState(() {
          _resultImg = value;
        }));
  }
}
