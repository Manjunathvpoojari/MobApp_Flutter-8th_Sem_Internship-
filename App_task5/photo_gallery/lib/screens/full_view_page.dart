import 'package:flutter/material.dart';

class FullViewPage extends StatelessWidget {
  final Color color;
  final int photoNumber;

  FullViewPage({required this.color, required this.photoNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo $photoNumber")),

      body: Container(
        color: color,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
