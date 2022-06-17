import 'dart:io';
import 'package:flutter/material.dart';
import '../helper.dart';
import '../logic.dart';
import '../widgets/result_box.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
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
          resultText = await MlLogic.barcodeScanner(imgFilePath);
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
