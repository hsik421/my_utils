



import 'package:flutter/painting.dart';

class ColorModel{
  final int r;
  final int g;
  final int b;
  final double alpha;

  ColorModel({
    required this.r,
    required this.g,
    required this.b,
    this.alpha = 1.0
  }){
    assert(r >= 0 && r <= 255);
    assert(g >= 0 && g <= 255);
    assert(b >= 0 && b <= 255);
    assert(alpha >= 0.0 && alpha <= 1.0);
  }
  factory ColorModel.fromColor(Color color) {
    return ColorModel(
      r: color.r.toInt(),
      g: color.g.toInt(),
      b: color.b.toInt(),
      alpha: color.a,
    );
  }
  factory ColorModel.fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    final colorInt = int.parse(buffer.toString(), radix: 16);

    return ColorModel.fromInt(colorInt);
  }
  factory ColorModel.fromInt(int colorInt) {
    int alphaByte = (colorInt >> 24) & 0xFF;
    int r = (colorInt >> 16) & 0xFF;
    int g = (colorInt >> 8) & 0xFF;
    int b = colorInt & 0xFF;
    return ColorModel(
      r: r,
      g: g,
      b: b,
      alpha: alphaByte / 255.0,
    );
  }
  Color toColor() {
    return Color.fromRGBO(r, g, b, alpha);
  }
  int toInt() {
    int a = (alpha * 255).round();
    return (a << 24) | (r << 16) | (g << 8) | b;
  }
  String toHex({bool leadingHashSign = true, bool withAlpha = true}) {
    if (withAlpha) {
      return '${leadingHashSign ? '#' : ''}${toInt().toRadixString(16).padLeft(8, '0')}';
    } else {
      final rHex = r.toRadixString(16).padLeft(2, '0');
      final gHex = g.toRadixString(16).padLeft(2, '0');
      final bHex = b.toRadixString(16).padLeft(2, '0');
      return '${leadingHashSign ? '#' : ''}$rHex$gHex$bHex';
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'r': r,
      'g': g,
      'b': b,
      'alpha': alpha,
      'hex': toHex(),
    };
  }
}