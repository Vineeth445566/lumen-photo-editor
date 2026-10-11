import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/filters.dart';
import 'crop_screen.dart';

class EditorScreen extends StatefulWidget {
  final File imageFile;

  const EditorScreen({super.key, required this.imageFile});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final GlobalKey _previewKey = GlobalKey();

  late Uint8List _imageBytes;
  int _quarterTurns = 0;

  int _filterIndex = 0;
  double _intensity = 1.0;
  bool _showOriginal = false; // hold-to-compare
  bool _showAdjust = false;
  bool _showFrames = false;
  PhotoFrame _frame = PhotoFrame.none;

  @override
  void initState() {
    super.initState();
    _imageBytes = widget.imageFile.readAsBytesSync();
  }

  Widget get _imageWidget => Image.memory(
        _imageBytes,
        fit: BoxFit.contain,
      );

  Future<void> _openCrop() async {
    final result = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
          builder: (_) => CropScreen(imageBytes: _imageBytes)),
    );
    if (result != null && mounted) {
      setState(() {
        _imageBytes = result;
        _quarterTurns = 0; // crop bakes in orientation
      });
    }
  }

  void _rotate() {
    setState(() => _quarterTurns = (_quarterTurns + 1) % 4);
  }

  final Map<Adjustment, double> _adjustments = {
    for (var a in Adjustment.values) a: 0,
  };
  Adjustment _selectedAdj = Adjustment.brightness;

  List<double> get _currentMatrix {
    if (_showOriginal) {
      return const [
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0,
      ];
    }
    final filter = photoFilters[_filterIndex].matrixAt(_intensity);
    final adj = adjustmentMatrix(
      brightness: _adjustments[Adjustment.brightness]!,
      contrast: _adjustments[Adjustment.contrast]!,
      saturation: _adjustments[Adjustment.saturation]!,
      warmth: _adjustments[Adjustment.warmth]!,
    );
    return combineMatrices(filter, adj);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Lumen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset all',
            onPressed: _reset,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Save',
            onPressed: _saveImage,
          ),
        ],
      ),
      body: Column(
        children: [
          // Preview
          Expanded(
            child: Center(
              child: GestureDetector(
                onLongPressStart: (_) => setState(() => _showOriginal = true),
                onLongPressEnd: (_) => setState(() => _showOriginal = false),
                child: RepaintBoundary(
                  key: _previewKey,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _frame == PhotoFrame.none
                          ? ColorFiltered(
                              colorFilter:
                                  ColorFilter.matrix(_currentMatrix),
                              child: RotatedBox(
                                quarterTurns: _quarterTurns,
                                child: _imageWidget,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.fromLTRB(
                                _frame.width,
                                _frame.width,
                                _frame.width,
                                _frame.width + _frame.bottomExtra,
                              ),
                              color: _frame.color,
                              child: ColorFiltered(
                                colorFilter:
                                    ColorFilter.matrix(_currentMatrix),
                                child: RotatedBox(
                                  quarterTurns: _quarterTurns,
                                  child: _imageWidget,
                                ),
                              ),
                            ),
                      // Vignette overlay
                      if (_adjustments[Adjustment.vignette]! > 0)
                        IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 0.75,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(
                                    alpha: _adjustments[
                                            Adjustment.vignette]! /
                                        100 *
                                        0.7,
                                  ),
                                ],
                                stops: const [0.55, 1.0],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Hold-to-compare hint
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              _showOriginal
                  ? 'Original'
                  : 'Hold photo to compare with original',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ),

          // Filter intensity slider
          if (_filterIndex != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.tune, color: Colors.white70, size: 18),
                  Expanded(
                    child: Slider(
                      value: _intensity,
                      min: 0,
                      max: 1,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white24,
                      onChanged: (v) =>
                          setState(() => _intensity = v),
                    ),
                  ),
                  Text(
                    '${(_intensity * 100).round()}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

          // Adjustment sliders
          if (_showAdjust) _buildAdjustPanel(),

          // Frame selector
          if (_showFrames) _buildFramePanel(),

          // Filter strip
          Container(
            height: 108,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: photoFilters.length,
              itemBuilder: (context, i) {
                final f = photoFilters[i];
                final selected = i == _filterIndex;
                return GestureDetector(
                  onTap: () => setState(() {
                    _filterIndex = i;
                    _intensity = 1.0;
                  }),
                  child: Container(
                    width: 72,
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.matrix(
                              f.matrixAt(1.0),
                            ),
                            child: Image.memory(
                              _imageBytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          f.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.white60,
                            fontSize: 11,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom toolbar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _toolButton(
                    Icons.filter_vintage,
                    'Filters',
                    !_showAdjust && !_showFrames,
                    () => setState(() {
                      _showAdjust = false;
                      _showFrames = false;
                    }),
                  ),
                  _toolButton(
                    Icons.tune,
                    'Adjust',
                    _showAdjust,
                    () => setState(() {
                      _showAdjust = true;
                      _showFrames = false;
                    }),
                  ),
                  _toolButton(
                    Icons.crop_original,
                    'Frame',
                    _showFrames,
                    () => setState(() {
                      _showFrames = true;
                      _showAdjust = false;
                    }),
                  ),
                  _toolButton(
                      Icons.crop, 'Crop', false, _openCrop),
                  _toolButton(
                      Icons.rotate_right, 'Rotate', false, _rotate),
                  _toolButton(Icons.share, 'Share', false, _shareImage),
                  _toolButton(
                      Icons.download, 'Save', false, _saveImage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolButton(
      IconData icon, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: active ? Colors.amber : Colors.white70,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: active ? Colors.amber : Colors.white70,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdjustPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: Adjustment.values.map((a) {
                final selected = a == _selectedAdj;
                final value = _adjustments[a]!;
                return GestureDetector(
                  onTap: () => setState(() => _selectedAdj = a),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white
                          : Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      value != 0
                          ? '${a.label} ${value.round()}'
                          : a.label,
                      style: TextStyle(
                        color:
                            selected ? Colors.black : Colors.white70,
                        fontSize: 12,
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
          Slider(
            value: _adjustments[_selectedAdj]!,
            min: _selectedAdj.min,
            max: _selectedAdj.max,
            activeColor: Colors.white,
            inactiveColor: Colors.white24,
            onChanged: (v) =>
                setState(() => _adjustments[_selectedAdj] = v),
          ),
        ],
      ),
    );
  }

  void _reset() {
    setState(() {
      _filterIndex = 0;
      _intensity = 1.0;
      _frame = PhotoFrame.none;
      _quarterTurns = 0;
      for (var a in Adjustment.values) {
        _adjustments[a] = 0;
      }
    });
  }

  Widget _buildFramePanel() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: PhotoFrame.values.map((f) {
          final selected = f == _frame;
          return GestureDetector(
            onTap: () => setState(() => _frame = f),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? Colors.white : Colors.white10,
                borderRadius: BorderRadius.circular(20),
                border: f.color != null
                    ? Border.all(
                        color: selected
                            ? Colors.black26
                            : f.color!,
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: Text(
                  f.label,
                  style: TextStyle(
                    color:
                        selected ? Colors.black : Colors.white70,
                    fontSize: 12,
                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<Uint8List?> _captureImage() async {
    try {
      final boundary = _previewKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  Future<void> _saveImage() async {
    final bytes = await _captureImage();
    if (bytes == null) {
      _toast('Could not render image');
      return;
    }
    try {
      await Gal.putImageBytes(bytes, name: 'lumen_${DateTime.now().millisecondsSinceEpoch}');
      _toast('Saved to gallery');
    } catch (e) {
      _toast('Save failed: $e');
    }
  }

  Future<void> _shareImage() async {
    final bytes = await _captureImage();
    if (bytes == null) {
      _toast('Could not render image');
      return;
    }
    final dir = await getTemporaryDirectory();
    final file = File(
        '${dir.path}/lumen_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], text: 'Edited with Lumen');
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
