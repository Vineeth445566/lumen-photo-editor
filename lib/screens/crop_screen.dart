import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

/// Aspect ratio presets for the crop screen.
enum CropRatio {
  free('Free', null),
  square('1:1', 1),
  landscape43('4:3', 4 / 3),
  portrait34('3:4', 3 / 4),
  landscape169('16:9', 16 / 9),
  portrait916('9:16', 9 / 16),
  landscape32('3:2', 3 / 2);

  const CropRatio(this.label, this.ratio);
  final String label;
  final double? ratio;
}

/// Crop screen. Takes image bytes, returns cropped PNG bytes (or null).
class CropScreen extends StatefulWidget {
  final Uint8List imageBytes;

  const CropScreen({super.key, required this.imageBytes});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final CropController _controller = CropController();
  CropRatio _ratio = CropRatio.free;
  bool _cropping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Crop'),
        actions: [
          _cropping
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    setState(() => _cropping = true);
                    _controller.crop();
                  },
                  child: const Text('Done',
                      style:
                          TextStyle(color: Colors.white, fontSize: 16)),
                ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Crop(
              // Key forces rebuild when aspect ratio changes
              key: ValueKey(_ratio),
              image: widget.imageBytes,
              controller: _controller,
              aspectRatio: _ratio.ratio,
              onCropped: (result) {
                if (!mounted) return;
                switch (result) {
                  case CropSuccess(:final croppedImage):
                    Navigator.of(context).pop(croppedImage);
                  case CropFailure():
                    setState(() => _cropping = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Crop failed, try again')),
                    );
                }
              },
              baseColor: Colors.black,
              maskColor: Colors.black.withValues(alpha: 0.6),
              cornerDotBuilder: (size, edgeAlignment) =>
                  const DotControl(color: Colors.white),
              interactive: true,
            ),
          ),
          // Aspect ratio presets
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: CropRatio.values.map((r) {
                  final selected = r == _ratio;
                  return GestureDetector(
                    onTap: () => setState(() => _ratio = r),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.white
                            : Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        r.label,
                        style: TextStyle(
                          color: selected
                              ? Colors.black
                              : Colors.white70,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
