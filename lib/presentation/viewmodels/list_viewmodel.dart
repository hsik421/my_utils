
import 'package:flutter/foundation.dart';

class ListViewModel extends ChangeNotifier {
  final List<String> _items = List.generate(50, (index) => "$index",);
  List<String> get items => _items;

  int _currentPageIndex = 0;

  void onInputChanged(String value) {
    notifyListeners();
  }

  void onPageTapped(int index) {
    _currentPageIndex = index;
    // 5. 상태가 변경되었음을 이 ViewModel을 구독(listen)하는 모든 위젯에게 알립니다.
    notifyListeners();
  }
}