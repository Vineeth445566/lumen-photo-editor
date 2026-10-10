// (no flutter import needed - pure Dart color math)

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
];

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
