import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultBox extends StatelessWidget {
  final String resultText;
  const ResultBox({Key? key, required this.resultText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (resultText == "") {
      return new Container();
    } else {
      return new InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: resultText));
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Copied to clipboard..")));
          },
          child: new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 0.6)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.copy, size: 18)),
              new Text(resultText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))
            ]),
          ));
    }
  }
}
