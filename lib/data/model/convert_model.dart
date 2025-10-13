import 'dart:convert';

class ConvertModel{
  ConvertCategory currentCategory;
  String name;
  String inputValue;
  String resultValue;
  ConvertModel({
    this.currentCategory = ConvertCategory.empty,
    this.name = '',
    this.inputValue = '',
    this.resultValue = '',
  });

  void convert() {
    resultValue = _convertValue(currentCategory, inputValue);
  }
  static String _convertValue(ConvertCategory category, String input) {
    switch (category) {
      case ConvertCategory.hexToAscii:
        return _hexToAscii(input);

      case ConvertCategory.hexToByte:
        return _hexToByte(input);

      case ConvertCategory.asciiToHex:
        return _asciiToHex(input);

      case ConvertCategory.asciiToByte:
        return _asciiToByte(input);

      case ConvertCategory.byteToHex:
        return _byteToHex(input);

      case ConvertCategory.byteToAscii:
        return _byteToAscii(input);

      case ConvertCategory.empty:
        return '';
    }
  }

  static String _hexToAscii(String hex) {
    try {
      hex = hex.replaceAll(' ', '');
      final bytes = <int>[];
      for (int i = 0; i < hex.length; i += 2) {
        bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
      }
      return utf8.decode(bytes);
    } catch (e) {
      return 'Invalid HEX';
    }
  }

  static String _hexToByte(String hex) {
    try {
      hex = hex.replaceAll(' ', '');
      final bytes = <int>[];
      for (int i = 0; i < hex.length; i += 2) {
        bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
      }
      return bytes.join(' ');
    } catch (e) {
      return 'Invalid HEX';
    }
  }

  static String _asciiToHex(String ascii) {
    return ascii.codeUnits.map((c) => c.toRadixString(16).padLeft(2, '0')).join(' ');
  }

  static String _asciiToByte(String ascii) {
    return ascii.codeUnits.join(' ');
  }

  static String _byteToHex(String byteStr) {
    try {
      final bytes = byteStr
          .split(RegExp(r'\s+'))
          .where((e) => e.isNotEmpty)
          .map((e) => int.parse(e))
          .toList();
      return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
    } catch (e) {
      return 'Invalid BYTE';
    }
  }

  static String _byteToAscii(String byteStr) {
    try {
      final bytes = byteStr
          .split(RegExp(r'\s+'))
          .where((e) => e.isNotEmpty)
          .map((e) => int.parse(e))
          .toList();
      return utf8.decode(bytes);
    } catch (e) {
      return 'Invalid BYTE';
    }
  }
}

enum ConvertCategory {
  hexToAscii,
  hexToByte,
  asciiToHex,
  asciiToByte,
  byteToHex,
  byteToAscii,
  empty,
}
extension ConvertCategoryExtension on ConvertCategory {
  String get displayName {
    switch (this) {
      case ConvertCategory.hexToAscii:
        return 'HEX → ASCII';
      case ConvertCategory.hexToByte:
        return 'HEX → Byte';
      case ConvertCategory.asciiToHex:
        return 'ASCII → HEX';
      case ConvertCategory.asciiToByte:
        return 'ASCII → Byte';
      case ConvertCategory.byteToHex:
        return 'Byte → HEX';
      case ConvertCategory.byteToAscii:
        return 'Byte → ASCII';
      case ConvertCategory.empty:
        return '';
    }
  }
}