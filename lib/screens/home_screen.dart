import 'package:firebase_ml_kit_flutter/helper/operation_enum.dart';
import 'package:firebase_ml_kit_flutter/screens/result_screen.dart';
import 'package:firebase_ml_kit_flutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ResultScreen> _screenList = [
    const ResultScreen(operation: Operations.TEXT_RECOGNITION),
    const ResultScreen(operation: Operations.IMAGE_LABELING),
    const ResultScreen(operation: Operations.FACE_DETECTION),
    const ResultScreen(operation: Operations.BARCODE_SCANNING),
    const ResultScreen(operation: Operations.LANGUAGE_IDENTIFICATION),
    const ResultScreen(operation: Operations.TRANSLATE),
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: _screenList.length,
        child: new Scaffold(
          appBar: const AppBarWithTabs(),
          body: new TabBarView(
            physics: const BouncingScrollPhysics(),
            children: _screenList,
          ),
        ));
  }
}
