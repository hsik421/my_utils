import 'package:flutter/material.dart';
import 'package:my_utils/data/model/convert_model.dart';
import 'package:my_utils/viewmodels/convert_viewmodel.dart';
import 'package:provider/provider.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ConvertPageState();
  }
}

class _ConvertPageState extends State<ConvertPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ConvertViewModel(),
        child: Consumer<ConvertViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: viewModel.items.length,
              itemBuilder: (context, index) {
                final item = viewModel.items[index];
                return ConvertItemView(item: item);
              },
            );
          },
        ));
  }
}

class ConvertItemView extends StatefulWidget {
  final ConvertModel item;

  const ConvertItemView({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _ConvertItemViewState();
}

class _ConvertItemViewState extends State<ConvertItemView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item.inputValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ConvertViewModel>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: '입력 값',
                border: OutlineInputBorder(),
                hintText: '여기에 값을 입력 하세요',
              ),
              onChanged: (value) {
                viewModel.onInputChanged(widget.item, value);
              },
            ),
            const SizedBox(height: 12),
            SelectableText('결과값: ${widget.item.resultValue}'),
          ],
        ),
      ),
    );
  }
}
