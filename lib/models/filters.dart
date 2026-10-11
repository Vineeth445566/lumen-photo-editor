import 'package:flutter/material.dart';

// (pure Dart color math below; Color used only for PhotoFrame)

/// A photo filter defined by a 4x5 color matrix.
/// Intensity lerps between identity (0.0) and the full filter (1.0).
class PhotoFilter {
  final String name;
  final String category;
  final List<double> matrix;

  const PhotoFilter({
    required this.name,
    required this.category,
    required this.matrix,
  });

  /// Blend this filter's matrix with identity by [intensity] (0.0 - 1.0).
  List<double> matrixAt(double intensity) {
    if (intensity <= 0) return _identity;
    if (intensity >= 1) return matrix;
    final out = List<double>.filled(20, 0);
    for (var i = 0; i < 20; i++) {
      out[i] = _identity[i] + (matrix[i] - _identity[i]) * intensity;
    }
    return out;
  }
}

const List<double> _identity = [
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0,
];

/// All bundled filters. Matrices tuned from VSCO / Lightroom / Picsart / Canva
/// reference styles (see research/filter-research.md).
const List<PhotoFilter> photoFilters = [
  PhotoFilter(name: 'Original', category: 'Basic', matrix: _identity),

  // ---- Black & white ----
  PhotoFilter(
    name: 'Mono',
    category: 'B&W',
    matrix: [
      0.299, 0.587, 0.114, 0, 0,
      0.299, 0.587, 0.114, 0, 0,
      0.299, 0.587, 0.114, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Noir',
    category: 'B&W',
    // Grayscale + crushed blacks, punchy contrast (Canva Noir)
    matrix: [
      0.45, 0.88, 0.17, 0, -38,
      0.45, 0.88, 0.17, 0, -38,
      0.45, 0.88, 0.17, 0, -38,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Sepia',
    category: 'B&W',
    matrix: [
      0.393, 0.769, 0.189, 0, 0,
      0.349, 0.686, 0.168, 0, 0,
      0.272, 0.534, 0.131, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Selenium',
    category: 'B&W',
    // Silvery-gray vintage tone (Lightroom Selenium Tone)
    matrix: [
      0.32, 0.63, 0.12, 0, 12,
      0.30, 0.60, 0.13, 0, 14,
      0.30, 0.58, 0.16, 0, 20,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Warm / vintage ----
  PhotoFilter(
    name: 'Vintage',
    category: 'Warm',
    // Warm overlay, lifted blacks, muted saturation (Lightroom Vintage Instant)
    matrix: [
      1.05, 0.08, -0.03, 0, 14,
      0.02, 0.98, 0.02, 0, 10,
      -0.06, 0.04, 0.88, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Aged',
    category: 'Warm',
    // Faded, yellowed old-photo look (Lightroom Aged Photo)
    matrix: [
      1.02, 0.10, 0.02, 0, 22,
      0.06, 0.94, 0.04, 0, 18,
      0.00, 0.06, 0.78, 0, 10,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Golden',
    category: 'Warm',
    // Golden hour glow: warm highlights, lifted shadows
    matrix: [
      1.12, 0.06, -0.02, 0, 10,
      0.04, 1.00, -0.02, 0, 6,
      -0.04, 0.02, 0.90, 0, -4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Cream',
    category: 'Warm',
    // VSCO P5-ish: warm creamy instant film
    matrix: [
      1.06, 0.05, 0.00, 0, 12,
      0.03, 1.00, 0.01, 0, 10,
      -0.02, 0.01, 0.92, 0, 4,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Cool ----
  PhotoFilter(
    name: 'Street',
    category: 'Cool',
    // Teal urban tones (Canva Street / Winter)
    matrix: [
      0.92, 0.02, 0.06, 0, -4,
      0.02, 1.00, 0.06, 0, 2,
      0.04, 0.08, 1.06, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Frost',
    category: 'Cool',
    // Icy blue cast, crisp
    matrix: [
      0.90, 0.00, 0.10, 0, -2,
      0.00, 0.98, 0.08, 0, 0,
      0.06, 0.10, 1.10, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Teal Orange',
    category: 'Cool',
    // Cinematic split-tone: teal shadows, warm highlights
    matrix: [
      0.98, 0.04, 0.06, 0, -8,
      0.00, 1.02, 0.08, 0, -2,
      0.02, 0.10, 1.02, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- VSCO-style film ----
  PhotoFilter(
    name: 'A6 Clean',
    category: 'Film',
    // VSCO A6: bright, crisp, subtle fade
    matrix: [
      1.08, 0.02, 0.00, 0, 6,
      0.01, 1.08, 0.01, 0, 6,
      0.00, 0.02, 1.06, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'F2 Fade',
    category: 'Film',
    // VSCO F2: desaturated, lifted blacks, quiet
    matrix: [
      0.82, 0.10, 0.06, 0, 26,
      0.08, 0.82, 0.08, 0, 26,
      0.06, 0.10, 0.78, 0, 28,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'C1 Dream',
    category: 'Film',
    // VSCO C1: dreamy soft warm
    matrix: [
      1.04, 0.06, 0.02, 0, 14,
      0.04, 0.98, 0.04, 0, 12,
      0.00, 0.04, 0.90, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'G8 Glow',
    category: 'Film',
    // VSCO G8: warm sun-kissed portrait
    matrix: [
      1.10, 0.05, -0.01, 0, 8,
      0.05, 1.02, 0.00, 0, 6,
      -0.02, 0.03, 0.92, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Matte',
    category: 'Film',
    // Lightroom Matte: low sat, high contrast, lifted blacks
    matrix: [
      1.02, -0.06, -0.02, 0, 18,
      -0.04, 1.04, -0.04, 0, 18,
      -0.02, -0.06, 1.00, 0, 20,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Mood ----
  PhotoFilter(
    name: 'Moody',
    category: 'Mood',
    // Dark & moody: crushed blacks, cool shadows
    matrix: [
      1.10, -0.02, 0.02, 0, -22,
      -0.02, 1.06, 0.04, 0, -20,
      0.02, 0.06, 1.08, 0, -14,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Airy',
    category: 'Mood',
    // Bright & airy: raised exposure, soft warm
    matrix: [
      1.04, 0.03, 0.01, 0, 30,
      0.02, 1.04, 0.02, 0, 30,
      0.00, 0.02, 1.00, 0, 28,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Punch',
    category: 'Mood',
    // Canva Epic: punchy contrast + vivid
    matrix: [
      1.18, -0.04, -0.02, 0, -12,
      -0.03, 1.20, -0.03, 0, -12,
      -0.02, -0.04, 1.16, 0, -10,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'X-Process',
    category: 'Mood',
    // Cross-processing: dramatic channel shifts (VSCO Q1-ish)
    matrix: [
      1.06, 0.10, -0.06, 0, 4,
      -0.04, 1.00, 0.12, 0, 0,
      0.10, -0.08, 1.04, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Pop',
    category: 'Mood',
    // Picsart Pop Art: bold saturated
    matrix: [
      1.25, -0.08, -0.05, 0, -6,
      -0.06, 1.28, -0.06, 0, -6,
      -0.05, -0.08, 1.22, 0, -4,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More B&W ----
  PhotoFilter(
    name: 'Contrast BW',
    category: 'B&W',
    matrix: [
      0.40, 0.78, 0.15, 0, -30,
      0.40, 0.78, 0.15, 0, -30,
      0.40, 0.78, 0.15, 0, -30,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Soft BW',
    category: 'B&W',
    matrix: [
      0.28, 0.55, 0.11, 0, 24,
      0.28, 0.55, 0.11, 0, 24,
      0.28, 0.55, 0.11, 0, 24,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Cyanotype',
    category: 'B&W',
    // Blue-tinted monochrome
    matrix: [
      0.20, 0.38, 0.08, 0, 8,
      0.26, 0.50, 0.12, 0, 22,
      0.32, 0.62, 0.18, 0, 48,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Warm BW',
    category: 'B&W',
    matrix: [
      0.34, 0.66, 0.13, 0, 14,
      0.30, 0.59, 0.12, 0, 8,
      0.26, 0.51, 0.11, 0, -2,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More warm ----
  PhotoFilter(
    name: 'Sunset',
    category: 'Warm',
    matrix: [
      1.14, 0.08, -0.04, 0, 6,
      0.06, 1.00, -0.02, 0, 0,
      -0.06, 0.00, 0.86, 0, -8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Honey',
    category: 'Warm',
    matrix: [
      1.10, 0.07, 0.01, 0, 10,
      0.05, 1.02, 0.02, 0, 8,
      -0.03, 0.02, 0.88, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Amber',
    category: 'Warm',
    matrix: [
      1.12, 0.09, 0.00, 0, 4,
      0.07, 1.00, 0.01, 0, 2,
      -0.05, -0.01, 0.84, 0, -6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Copper',
    category: 'Warm',
    matrix: [
      1.08, 0.10, 0.02, 0, -4,
      0.08, 0.96, 0.03, 0, -6,
      -0.02, 0.02, 0.82, 0, -12,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Tuscan',
    category: 'Warm',
    // Warm Mediterranean earth tones
    matrix: [
      1.06, 0.08, 0.00, 0, 8,
      0.06, 0.98, 0.02, 0, 4,
      -0.04, 0.00, 0.86, 0, -4,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More cool ----
  PhotoFilter(
    name: 'Arctic',
    category: 'Cool',
    matrix: [
      0.88, 0.02, 0.12, 0, 6,
      0.02, 0.98, 0.10, 0, 8,
      0.08, 0.12, 1.12, 0, 14,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Ocean',
    category: 'Cool',
    matrix: [
      0.86, 0.06, 0.10, 0, -2,
      0.04, 1.04, 0.10, 0, 2,
      0.06, 0.14, 1.08, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Midnight',
    category: 'Cool',
    // Deep blue night tones
    matrix: [
      0.90, -0.02, 0.08, 0, -18,
      0.00, 0.96, 0.10, 0, -14,
      0.06, 0.10, 1.10, 0, -6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Emerald',
    category: 'Cool',
    matrix: [
      0.90, 0.04, 0.04, 0, -4,
      0.02, 1.08, 0.06, 0, 4,
      0.02, 0.08, 1.00, 0, 2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Lavender',
    category: 'Cool',
    matrix: [
      1.02, 0.02, 0.06, 0, 10,
      0.02, 0.96, 0.08, 0, 8,
      0.06, 0.04, 1.08, 0, 14,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More film (VSCO-style) ----
  PhotoFilter(
    name: 'A4 Warm',
    category: 'Film',
    // VSCO A4: warm moody analog
    matrix: [
      1.06, 0.07, -0.01, 0, 8,
      0.04, 1.00, 0.01, 0, 6,
      -0.04, 0.02, 0.92, 0, 2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'E2 Glow',
    category: 'Film',
    // VSCO E2: clean bright golden highlights
    matrix: [
      1.10, 0.04, 0.00, 0, 14,
      0.03, 1.06, 0.01, 0, 12,
      -0.01, 0.02, 0.96, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'M5 Pop',
    category: 'Film',
    // VSCO M5: balanced, outdoor pop
    matrix: [
      1.08, 0.00, 0.00, 0, 2,
      0.00, 1.10, 0.00, 0, 2,
      0.00, 0.02, 1.06, 0, 4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'S1 Bright',
    category: 'Film',
    // VSCO S1: bright clean skin tones
    matrix: [
      1.06, 0.02, 0.00, 0, 20,
      0.02, 1.06, 0.02, 0, 20,
      0.00, 0.02, 1.02, 0, 20,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'K1 Chrome',
    category: 'Film',
    // Kodachrome: bold classic colors
    matrix: [
      1.14, -0.02, -0.02, 0, -4,
      -0.02, 1.12, 0.00, 0, -2,
      -0.02, 0.02, 1.10, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'H1 Blush',
    category: 'Film',
    // Subtle pink hues
    matrix: [
      1.06, 0.03, 0.03, 0, 10,
      0.02, 0.98, 0.04, 0, 8,
      0.04, 0.02, 1.02, 0, 12,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'U5 Dusk',
    category: 'Film',
    // Rich oranges, dynamic blues
    matrix: [
      1.10, 0.05, -0.02, 0, 0,
      0.03, 1.00, 0.03, 0, -2,
      -0.02, 0.06, 1.06, 0, 4,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Vintage / retro ----
  PhotoFilter(
    name: '70s',
    category: 'Retro',
    matrix: [
      1.04, 0.10, 0.02, 0, 16,
      0.08, 0.96, 0.04, 0, 12,
      0.02, 0.06, 0.80, 0, 4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: '80s',
    category: 'Retro',
    // Punchy neon-tinted retro
    matrix: [
      1.08, 0.02, 0.06, 0, 4,
      0.00, 1.04, 0.08, 0, 2,
      0.06, 0.02, 1.08, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Polaroid',
    category: 'Retro',
    matrix: [
      1.02, 0.06, 0.02, 0, 24,
      0.05, 1.00, 0.03, 0, 22,
      0.01, 0.04, 0.90, 0, 16,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Lomo',
    category: 'Retro',
    // Saturated center, vignette-ish contrast
    matrix: [
      1.12, -0.02, 0.02, 0, -8,
      -0.01, 1.14, 0.01, 0, -8,
      0.02, -0.01, 1.08, 0, -4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Faded Film',
    category: 'Retro',
    matrix: [
      0.92, 0.08, 0.06, 0, 30,
      0.07, 0.92, 0.07, 0, 30,
      0.06, 0.08, 0.88, 0, 32,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Cinematic ----
  PhotoFilter(
    name: 'Blockbuster',
    category: 'Cinema',
    // Strong teal & orange
    matrix: [
      1.02, 0.02, 0.08, 0, -12,
      -0.02, 1.04, 0.10, 0, -8,
      0.00, 0.12, 1.04, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Western',
    category: 'Cinema',
    // Dusty warm desaturated
    matrix: [
      1.04, 0.08, 0.00, 0, 6,
      0.06, 0.96, 0.02, 0, 2,
      -0.02, 0.02, 0.84, 0, -6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Noir Green',
    category: 'Cinema',
    // Desaturated horror green
    matrix: [
      0.88, 0.10, 0.02, 0, -6,
      0.06, 1.00, 0.06, 0, -4,
      0.02, 0.08, 0.82, 0, -8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Romance',
    category: 'Cinema',
    // Soft pink glow
    matrix: [
      1.08, 0.04, 0.04, 0, 18,
      0.03, 1.00, 0.05, 0, 16,
      0.05, 0.03, 1.04, 0, 20,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Nature ----
  PhotoFilter(
    name: 'Forest',
    category: 'Nature',
    matrix: [
      0.94, 0.04, 0.00, 0, -2,
      0.02, 1.10, 0.04, 0, 4,
      0.00, 0.06, 0.94, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Desert',
    category: 'Nature',
    matrix: [
      1.10, 0.08, 0.00, 0, 8,
      0.07, 1.02, 0.01, 0, 6,
      -0.03, 0.01, 0.86, 0, -2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Tropical',
    category: 'Nature',
    // Vivid greens and blues
    matrix: [
      0.96, 0.02, 0.06, 0, 2,
      0.00, 1.12, 0.06, 0, 4,
      0.04, 0.08, 1.10, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- Artistic ----
  PhotoFilter(
    name: 'Duo Blue',
    category: 'Art',
    // Duotone: deep blue shadows, light blue highlights
    matrix: [
      0.30, 0.59, 0.11, 0, 10,
      0.32, 0.62, 0.14, 0, 40,
      0.36, 0.68, 0.22, 0, 90,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Duo Ember',
    category: 'Art',
    // Duotone: warm ember tones
    matrix: [
      0.36, 0.68, 0.16, 0, 70,
      0.30, 0.59, 0.12, 0, 30,
      0.26, 0.50, 0.10, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Infrared',
    category: 'Art',
    // False-color infrared look
    matrix: [
      0.10, 0.30, 0.80, 0, 0,
      0.70, 0.40, 0.10, 0, 0,
      0.20, 0.10, 0.30, 0, 10,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Pastel',
    category: 'Art',
    // Soft desaturated pastels
    matrix: [
      0.90, 0.06, 0.06, 0, 36,
      0.06, 0.90, 0.06, 0, 36,
      0.06, 0.06, 0.90, 0, 36,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More B&W ----
  PhotoFilter(
    name: 'Platinum',
    category: 'B&W',
    matrix: [
      0.30, 0.59, 0.11, 0, 30,
      0.30, 0.59, 0.11, 0, 32,
      0.30, 0.59, 0.11, 0, 38,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Charcoal',
    category: 'B&W',
    matrix: [
      0.36, 0.70, 0.14, 0, -36,
      0.36, 0.70, 0.14, 0, -36,
      0.36, 0.70, 0.14, 0, -36,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Paper',
    category: 'B&W',
    matrix: [
      0.32, 0.62, 0.12, 0, 28,
      0.30, 0.60, 0.12, 0, 24,
      0.28, 0.55, 0.11, 0, 18,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Silver',
    category: 'B&W',
    matrix: [
      0.33, 0.64, 0.13, 0, 16,
      0.32, 0.63, 0.13, 0, 18,
      0.33, 0.63, 0.15, 0, 24,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More warm ----
  PhotoFilter(
    name: 'Candlelight',
    category: 'Warm',
    matrix: [
      1.12, 0.10, 0.02, 0, -8,
      0.08, 1.00, 0.02, 0, -10,
      -0.04, 0.00, 0.84, 0, -16,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Bonfire',
    category: 'Warm',
    matrix: [
      1.16, 0.08, -0.02, 0, -6,
      0.08, 1.02, -0.01, 0, -8,
      -0.06, -0.02, 0.82, 0, -14,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Harvest',
    category: 'Warm',
    matrix: [
      1.08, 0.09, 0.01, 0, 6,
      0.07, 1.00, 0.03, 0, 4,
      -0.02, 0.03, 0.86, 0, -2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Sienna',
    category: 'Warm',
    matrix: [
      1.10, 0.06, 0.00, 0, 0,
      0.06, 0.98, 0.02, 0, -2,
      -0.03, 0.01, 0.86, 0, -8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Terracotta',
    category: 'Warm',
    matrix: [
      1.08, 0.08, 0.02, 0, 2,
      0.07, 0.97, 0.03, 0, 0,
      -0.01, 0.02, 0.85, 0, -6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Caramel',
    category: 'Warm',
    matrix: [
      1.09, 0.07, 0.01, 0, 12,
      0.06, 1.01, 0.02, 0, 10,
      -0.02, 0.02, 0.89, 0, 4,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More cool ----
  PhotoFilter(
    name: 'Glacier',
    category: 'Cool',
    matrix: [
      0.86, 0.04, 0.14, 0, 10,
      0.03, 0.98, 0.12, 0, 12,
      0.09, 0.14, 1.14, 0, 18,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Slate',
    category: 'Cool',
    matrix: [
      0.92, 0.02, 0.06, 0, -6,
      0.02, 0.98, 0.08, 0, -4,
      0.05, 0.08, 1.04, 0, 2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Indigo',
    category: 'Cool',
    matrix: [
      0.94, 0.00, 0.10, 0, -4,
      0.00, 0.94, 0.10, 0, -2,
      0.08, 0.08, 1.10, 0, 8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Periwinkle',
    category: 'Cool',
    matrix: [
      1.00, 0.03, 0.08, 0, 12,
      0.03, 0.97, 0.09, 0, 12,
      0.08, 0.06, 1.09, 0, 18,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Mint',
    category: 'Cool',
    matrix: [
      0.94, 0.05, 0.05, 0, 8,
      0.03, 1.06, 0.07, 0, 10,
      0.04, 0.09, 1.02, 0, 12,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Aegean',
    category: 'Cool',
    matrix: [
      0.88, 0.05, 0.09, 0, 0,
      0.03, 1.02, 0.11, 0, 4,
      0.05, 0.12, 1.07, 0, 10,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More film ----
  PhotoFilter(
    name: 'Portra',
    category: 'Film',
    // Warm portrait film, soft
    matrix: [
      1.05, 0.05, 0.01, 0, 12,
      0.04, 1.00, 0.02, 0, 10,
      0.00, 0.03, 0.93, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Ektar',
    category: 'Film',
    // Vivid landscape film
    matrix: [
      1.10, -0.01, 0.01, 0, 0,
      -0.01, 1.12, 0.01, 0, 2,
      0.01, 0.00, 1.08, 0, 4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Tri-X',
    category: 'Film',
    // Classic B&W film grain feel
    matrix: [
      0.34, 0.66, 0.13, 0, -8,
      0.34, 0.66, 0.13, 0, -8,
      0.34, 0.66, 0.13, 0, -8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Cinestill',
    category: 'Film',
    // Warm halation glow
    matrix: [
      1.09, 0.06, 0.00, 0, 10,
      0.05, 1.01, 0.02, 0, 8,
      -0.03, 0.01, 0.90, 0, 2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Gold 200',
    category: 'Film',
    matrix: [
      1.08, 0.07, 0.00, 0, 8,
      0.06, 1.02, 0.01, 0, 6,
      -0.02, 0.02, 0.90, 0, 0,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More retro ----
  PhotoFilter(
    name: 'VHS',
    category: 'Retro',
    matrix: [
      1.02, 0.04, 0.08, 0, 6,
      0.02, 1.00, 0.10, 0, 4,
      0.08, 0.04, 1.04, 0, 10,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Camcorder',
    category: 'Retro',
    matrix: [
      1.04, 0.05, 0.03, 0, 14,
      0.04, 1.00, 0.05, 0, 12,
      0.03, 0.05, 0.96, 0, 10,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Disco',
    category: 'Retro',
    matrix: [
      1.06, 0.04, 0.08, 0, 8,
      0.02, 1.02, 0.10, 0, 6,
      0.08, 0.04, 1.06, 0, 12,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Grunge',
    category: 'Retro',
    matrix: [
      1.02, -0.03, 0.01, 0, -14,
      -0.02, 1.00, 0.02, 0, -12,
      0.01, 0.03, 0.98, 0, -8,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Light Leak',
    category: 'Retro',
    matrix: [
      1.10, 0.06, 0.02, 0, 20,
      0.04, 1.02, 0.03, 0, 16,
      0.00, 0.03, 0.92, 0, 10,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More cinema ----
  PhotoFilter(
    name: 'Neo-Noir',
    category: 'Cinema',
    matrix: [
      1.04, -0.02, 0.06, 0, -10,
      -0.02, 0.98, 0.08, 0, -8,
      0.04, 0.06, 1.06, 0, -2,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Cyberpunk',
    category: 'Cinema',
    // Neon magenta/cyan
    matrix: [
      1.08, 0.00, 0.10, 0, 0,
      -0.02, 1.00, 0.12, 0, 0,
      0.10, 0.02, 1.08, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Wes',
    category: 'Cinema',
    // Pastel symmetrical tones
    matrix: [
      1.02, 0.04, 0.04, 0, 22,
      0.04, 1.00, 0.05, 0, 22,
      0.04, 0.05, 1.00, 0, 24,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Giallo',
    category: 'Cinema',
    // Vivid saturated thriller
    matrix: [
      1.16, -0.03, 0.01, 0, -4,
      -0.02, 1.14, -0.01, 0, -4,
      0.01, -0.02, 1.10, 0, -2,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More nature ----
  PhotoFilter(
    name: 'Autumn',
    category: 'Nature',
    matrix: [
      1.10, 0.07, -0.01, 0, 4,
      0.06, 1.00, 0.01, 0, 2,
      -0.04, 0.00, 0.88, 0, -4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Spring',
    category: 'Nature',
    matrix: [
      1.02, 0.03, 0.03, 0, 14,
      0.02, 1.06, 0.04, 0, 14,
      0.03, 0.04, 1.02, 0, 16,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Meadow',
    category: 'Nature',
    matrix: [
      0.98, 0.03, 0.01, 0, 6,
      0.02, 1.08, 0.03, 0, 8,
      0.01, 0.05, 0.98, 0, 6,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Canyon',
    category: 'Nature',
    matrix: [
      1.09, 0.07, 0.00, 0, 2,
      0.06, 1.00, 0.02, 0, 0,
      -0.03, 0.01, 0.87, 0, -6,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More art ----
  PhotoFilter(
    name: 'Duo Purple',
    category: 'Art',
    matrix: [
      0.34, 0.60, 0.16, 0, 50,
      0.30, 0.56, 0.14, 0, 20,
      0.34, 0.60, 0.22, 0, 70,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Duo Green',
    category: 'Art',
    matrix: [
      0.30, 0.60, 0.12, 0, 20,
      0.32, 0.64, 0.14, 0, 60,
      0.30, 0.58, 0.14, 0, 30,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Solarize',
    category: 'Art',
    // Partial inversion feel
    matrix: [
      -0.60, 0.20, 0.20, 0, 160,
      0.20, -0.60, 0.20, 0, 160,
      0.20, 0.20, -0.60, 0, 160,
      0, 0, 0, 1, 0,
    ],
  ),

  // ---- More mood ----
  PhotoFilter(
    name: 'Ethereal',
    category: 'Mood',
    matrix: [
      1.00, 0.04, 0.04, 0, 44,
      0.04, 1.00, 0.04, 0, 44,
      0.04, 0.04, 1.00, 0, 44,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Dramatic',
    category: 'Mood',
    matrix: [
      1.16, -0.04, -0.02, 0, -18,
      -0.03, 1.16, -0.03, 0, -18,
      -0.02, -0.04, 1.14, 0, -16,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Hazy',
    category: 'Mood',
    matrix: [
      0.94, 0.04, 0.04, 0, 36,
      0.04, 0.94, 0.04, 0, 36,
      0.04, 0.04, 0.94, 0, 36,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Crisp',
    category: 'Mood',
    matrix: [
      1.10, -0.02, -0.01, 0, -6,
      -0.02, 1.10, -0.02, 0, -6,
      -0.01, -0.02, 1.08, 0, -4,
      0, 0, 0, 1, 0,
    ],
  ),
  PhotoFilter(
    name: 'Muted',
    category: 'Mood',
    matrix: [
      0.88, 0.06, 0.04, 0, 12,
      0.05, 0.88, 0.05, 0, 12,
      0.04, 0.06, 0.88, 0, 12,
      0, 0, 0, 1, 0,
    ],
  ),
];

/// Frame/border styles applied around the photo.
enum PhotoFrame {
  none('None', null, 0),
  polaroid('Polaroid', Colors.white, 28, bottomExtra: 56),
  white('White', Colors.white, 16),
  black('Black', Colors.black, 16),
  thinWhite('Thin W', Colors.white, 6),
  thinBlack('Thin B', Colors.black, 6);

  const PhotoFrame(this.label, this.color, this.width,
      {this.bottomExtra = 0});
  final String label;
  final Color? color;
  final double width;
  final double bottomExtra;
}

/// Adjustment sliders applied on top of the selected filter.
enum Adjustment {
  brightness('Brightness', -100, 100),
  contrast('Contrast', -100, 100),
  saturation('Saturation', -100, 100),
  warmth('Warmth', -100, 100),
  vignette('Vignette', 0, 100);

  const Adjustment(this.label, this.min, this.max);
  final String label;
  final double min;
  final double max;
}

/// Builds a combined color matrix from adjustment values.
/// Each value is -100..100 (vignette 0..100).
List<double> adjustmentMatrix({
  double brightness = 0,
  double contrast = 0,
  double saturation = 0,
  double warmth = 0,
}) {
  // Start from identity
  var m = List<double>.from(_identity);

  // Brightness: add offset
  final b = brightness / 100 * 40;
  m[4] += b;
  m[9] += b;
  m[14] += b;

  // Contrast: scale around 128
  if (contrast != 0) {
    final c = (contrast / 100 * 0.8) + 1;
    final t = 128 * (1 - c);
    m = _multiply([
      c, 0, 0, 0, t,
      0, c, 0, 0, t,
      0, 0, c, 0, t,
      0, 0, 0, 1, 0,
    ], m);
  }

  // Saturation
  if (saturation != 0) {
    final s = (saturation / 100) + 1;
    final sr = (1 - s) * 0.299;
    final sg = (1 - s) * 0.587;
    final sb = (1 - s) * 0.114;
    m = _multiply([
      sr + s, sg, sb, 0, 0,
      sr, sg + s, sb, 0, 0,
      sr, sg, sb + s, 0, 0,
      0, 0, 0, 1, 0,
    ], m);
  }

  // Warmth: shift red/blue balance
  if (warmth != 0) {
    final w = warmth / 100;
    m = _multiply([
      1 + w * 0.12, 0, 0, 0, w * 8,
      0, 1, 0, 0, 0,
      0, 0, 1 - w * 0.12, 0, -w * 8,
      0, 0, 0, 1, 0,
    ], m);
  }

  return m;
}

/// Multiply two 4x5 color matrices: result = a * b.
List<double> _multiply(List<double> a, List<double> b) {
  final out = List<double>.filled(20, 0);
  for (var row = 0; row < 4; row++) {
    for (var col = 0; col < 5; col++) {
      var sum = 0.0;
      for (var k = 0; k < 4; k++) {
        sum += a[row * 5 + k] * b[k * 5 + col];
      }
      if (col == 4) sum += a[row * 5 + 4];
      out[row * 5 + col] = sum;
    }
  }
  return out;
}

/// Combine filter matrix with adjustment matrix: result = adjustments * filter.
List<double> combineMatrices(List<double> filter, List<double> adjustments) {
  return _multiply(adjustments, filter);
}
