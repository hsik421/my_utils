import 'package:my_utils/data/models/convert_model.dart';
import 'package:flutter/foundation.dart';

class ConvertViewModel extends ChangeNotifier {
  final List<ConvertModel> _items = ConvertCategory
      .values
      .where((category) => category != ConvertCategory.empty)
      .map((e) => ConvertModel(currentCategory: e, name: e.displayName),)
      .toList();
  List<ConvertModel> get items => _items;

  void onInputChanged(ConvertModel item, String value) {
    item.inputValue = value;
    item.convert();
    notifyListeners();
  }
}