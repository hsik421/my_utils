import 'package:flutter/material.dart';
import 'package:my_utils/presentation/viewmodels/list_viewmodel.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState(); // State 타입 명시
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    // 반드시 Scaffold로 감싸야 합니다.
    return ChangeNotifierProvider(
      create: (context) => ListViewModel(),
      child: Consumer<ListViewModel>(
          builder: (context, value, child) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    floating: true,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text("Test"),
                      background: Container(color: Colors.orange),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SearchDelegate(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => ListTile(
                          title: Text("Item $index"),
                        ),
                        childCount: 100,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
      ),
    );
  }
}

class _SearchDelegate extends SliverPersistentHeaderDelegate {
  // final TextEditingController controller;
  // _SearchDelegate({required this.controller});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final viewModel = context.read<ListViewModel>();
    return Material(
      color: Colors.white,
      elevation: overlapsContent ? 4 : 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.center,
        child: TextField(
          decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.grey[200]),
          onChanged: (value) {
            print(value);
            viewModel.onInputChanged(value);
          },
          onSubmitted: (value){
            // context.read<ListViewModel>().onInputChanged(value);
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70.0;

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(covariant _SearchDelegate oldDelegate) => false;
}