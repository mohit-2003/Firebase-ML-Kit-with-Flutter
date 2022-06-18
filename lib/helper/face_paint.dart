import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FacePainter extends CustomPainter {
  List<Rect> rectList;
  final ui.Image imageFile;

  FacePainter({required this.rectList, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(imageFile, Offset.zero, Paint());

    for (Rect rect in rectList) {
      canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.red
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
