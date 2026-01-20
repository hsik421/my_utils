
import 'package:flutter/foundation.dart';
import 'package:my_utils/data/models/color_model.dart';

class ColorViewModel extends ChangeNotifier{


  ColorModel _colorValue = ColorModel(r: 255, g: 255, b: 255);
  ColorModel get colorValue => _colorValue;

  String _message = "input";
  String get message => _message;

  void onInputValue(String inputString){
    print(inputString);
    _formatColorValue(inputString);
    notifyListeners();
  }

  void _formatColorValue(String text){
    int commaCount = RegExp(',').allMatches(text).length;
    _message = "input";
    try{
      switch(commaCount){
        case 0:
          if(text.length == 8){
            _colorValue = ColorModel.fromHex(text);
            break;
          }else if(text.length == 6){
            _colorValue = ColorModel.fromHex(text);
            break;
          }else{
            throw FormatException("please check input value.");
          }
          break;
        case 2:
          List<int?> array = _convertCommaStringToIntArray(text);
          _colorValue = ColorModel(r: array[0] ?? 0, g: array[1] ?? 0, b: array[2] ?? 0, alpha: 1);
          break;
        case 3:
          List<int?> array = _convertCommaStringToIntArray(text);
          _colorValue = ColorModel(r: array[0] ?? 0, g: array[1] ?? 0, b: array[2] ?? 0, alpha: array[3]?.toDouble() ?? 1);
          break;
        default:
          throw FormatException("please check input value.");
      }
    } on FormatException catch (e){
      print(e.message);
      _message = e.message;
    }
  }
  List<int?> _convertCommaStringToIntArray(String text){
    return text.split(',')
        .map((e) => int.tryParse(e.trim()))
        .toList();
  }
}