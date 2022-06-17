import 'dart:io';

import 'package:flutter/material.dart';

import '../logic.dart';
import '../widgets/result_box.dart';

class LanguageIdentifierScreen extends StatefulWidget {
  const LanguageIdentifierScreen({Key? key}) : super(key: key);

  @override
  State<LanguageIdentifierScreen> createState() =>
      _LanguageIdentifierScreenState();
}

class _LanguageIdentifierScreenState extends State<LanguageIdentifierScreen> {
  String resultText = "";
  final controller = new TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  margin: const EdgeInsets.all(8),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        hintText: "Enter some text in any language"),
                  ),
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
            resultText = await MlLogic.languageIdentifier(controller.text);
            setState(() {});
          },
        ));
  }
}
