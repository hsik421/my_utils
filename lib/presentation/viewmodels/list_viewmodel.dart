
import 'package:flutter/foundation.dart';

class ListViewModel extends ChangeNotifier {
  final List<String> _items = List.generate(50, (index) => "$index",);
  List<String> get items => _items;

  void onInputChanged(String value) {
    notifyListeners();
  }
}