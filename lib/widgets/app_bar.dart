import 'package:flutter/material.dart';

class AppBarWithTabs extends StatelessWidget with PreferredSizeWidget {
  const AppBarWithTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: const Text("ML Kit"),
      bottom: const TabBar(isScrollable: true, tabs: [
        Tab(text: "Text Recognition"),
        Tab(text: "Image Labeling"),
        Tab(text: "Face Detection"),
        Tab(text: "Barcode Scanning"),
        Tab(text: "Language Identification"),
        // Tab(text: "Object Detection and Tracking"),
        // Tab(text: "Digital Ink Recognition"),
        // Tab(text: "Pose Detection"),
        // Tab(text: "Selfie Segmentation"),
        Tab(text: "On-Device Translation"),
        // Tab(text: "Smart Reply"),
        // Tab(text: "Entity Extraction"),
      ]),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
