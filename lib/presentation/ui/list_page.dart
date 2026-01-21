import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/presentation/ui/list_bottom_items_view.dart';
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
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: false,
                        floating: true,
                        expandedHeight: kToolbarHeight,
                        flexibleSpace: FlexibleSpaceBar(
                          title: const Text("Test"),
                          background: Container(color: Colors.orange),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SearchDelegate(),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("타이틀 또는 다른 콘텐츠"),
                            ),
                            SizedBox(
                              height: 150.0, // 가로 리스트의 높이를 반드시 지정해야 합니다.
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ListItemView(item: '$index');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => ListTile(
                              title: Text("Item $index"),
                            ),
                            childCount: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListBottomItemsView(
                  onItemTapped: (index) {
                    viewModel.onPageTapped(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}

class ListItemView extends StatefulWidget {
  final String item;

  const ListItemView({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _ListItemViewState();
}

class _ListItemViewState extends State<ListItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      padding: EdgeInsets.only(left: 3.0),
      child: AspectRatio(
        // 1. AspectRatio 위젯 추가
        aspectRatio: 4 / 3, // 4:3 비율 설정
        child: Card(
          color: Colors.teal,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            // Column이 Card의 전체 공간을 사용하도록 설정
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2. 이미지가 남은 공간을 모두 차지하도록 Expanded로 감싸기
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: "https://picsum.photos/400/300",
                  // 4:3 비율 이미지 예시
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  // width, height를 직접 지정하지 않고 fit으로 채웁니다.
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "test : ${widget.item}",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _SearchDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.grey[200]),
          onChanged: (value) {
            print(value);
            viewModel.onInputChanged(value);
          },
          onSubmitted: (value) {
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
