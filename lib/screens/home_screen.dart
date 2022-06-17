import 'package:firebase_ml_kit_flutter/screens/face_detection_screen.dart';
import 'package:firebase_ml_kit_flutter/screens/image_labeling_screen.dart';
import 'package:firebase_ml_kit_flutter/screens/text_recognition_screen.dart';
import 'package:firebase_ml_kit_flutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _screenList = [
    const TextRecognitionScreen(),
    const FaceDetectionScreen(),
    const ImageLabelingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: const AppBarWithTabs(),
          body: new TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: _screenList,
          ),
        ));
  }
}
