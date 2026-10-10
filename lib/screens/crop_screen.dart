import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

/// Crop screen using crop_your_image. Returns cropped PNG bytes, or null.
class CropScreen extends StatefulWidget {
  final File imageFile;

  const CropScreen({super.key, required this.imageFile});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final CropController _controller = CropController();
  late final Uint8List _imageBytes;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _imageBytes = widget.imageFile.readAsBytesSync();
    // Let the first frame render before showing the cropper.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Crop'),
        actions: [
          TextButton(
            onPressed: () => _controller.crop(),
            child: const Text('Done',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
      body: _ready
          ? Crop(
              image: _imageBytes,
              controller: _controller,
              onCropped: (cropped) {
                Navigator.of(context).pop(cropped);
              },
              baseColor: Colors.black,
              maskColor: Colors.black.withValues(alpha: 0.6),
              cornerDotBuilder: (size, edgeAlignment) =>
                  const DotControl(color: Colors.white),
              interactive: true,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
