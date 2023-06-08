import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ImgPreview extends StatefulWidget {
  ImgPreview({super.key, required this.file});
  XFile file;
  @override
  State<ImgPreview> createState() => ImgPreviewState();
}

class ImgPreviewState extends State<ImgPreview> {
  @override
  Widget build(BuildContext context) {
    // File picture = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: const Center(child: Text('Hii')
          // Image.file(picture)
          ),
    );
  }
}
