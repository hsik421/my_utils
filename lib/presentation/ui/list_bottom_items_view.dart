import 'package:flutter/material.dart';

class ListBottomItemsView extends StatefulWidget {
  // 부모 위젯에서 탭 이벤트를 전달받기 위한 콜백 함수
  final Function(int) onItemTapped;

  const ListBottomItemsView({super.key, required this.onItemTapped});

  @override
  State<ListBottomItemsView> createState() => _ListBottomItemsViewState();
}

class _ListBottomItemsViewState extends State<ListBottomItemsView> {
  int _selectedIndex = 0;

  void _handleItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // 부모에게 현재 탭된 인덱스를 전달합니다.
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1.0)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildBottomMenuItem(icon: Icons.home, label: '홈', index: 0)),
          Expanded(child: _buildBottomMenuItem(icon: Icons.search, label: '검색', index: 1)),
          Expanded(child: _buildBottomMenuItem(icon: Icons.favorite, label: '찜', index: 2)),
          Expanded(child: _buildBottomMenuItem(icon: Icons.person, label: '마이페이지', index: 3)),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? Theme.of(context).primaryColor : Colors.grey[700]!;

    return InkWell(
      onTap: () => _handleItemTapped(index),
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28.0, color: color),
            const SizedBox(height: 4.0),
            Text(label, style: TextStyle(fontSize: 12.0, color: color)),
          ],
        ),
      ),
    );
  }
}