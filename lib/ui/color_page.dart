import 'package:flutter/material.dart';
import 'package:my_utils/viewmodels/color_viewmodel.dart';
import 'package:provider/provider.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ColorPageState();
  }

}

class _ColorPageState extends State<ColorPage>{
  late TextEditingController _inputController;

  @override
  void initState() {

    super.initState();
    _inputController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ColorViewModel(),
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: Consumer<ColorViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _inputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: viewModel.message,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.onInputValue(_inputController.text);
                          },
                          child: Text("OK"),
                        )
                      ],
                    ),
                    Text('ex)\nhex : 6,8 length \nrgb : XXX,XXX,XXX\nargb : XXX,XXX,XXX,XXX'),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue),
                      ),
                      child: SelectableText(viewModel.colorValue.toJson().toString()),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: viewModel.colorValue.toColor()
                      )
                    )
                  ],
                );
              },
            )
        ),
      )
    );

  }
}