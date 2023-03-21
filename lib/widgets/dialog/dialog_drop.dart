import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';

class DialogDrop extends StatefulWidget {
  final double dialogWidth;
  final double dialogHeight;
  final String dialogImg;
  final double dialogImgWidth;
  final double dialogImgHeight;
  final String dialogTopText;
  final String dialogBottomText;
  final String primaryBtText;
  final String secondaryBtText;
  final bool primaryBtIsShow;
  final bool secondaryBtIsShow;
  final VoidCallback primaryCallback;
  final VoidCallback secondaryCallback;

  const DialogDrop(
      {Key? key,
      required this.dialogWidth,
      required this.dialogHeight,
      required this.dialogImg,
      required this.dialogImgWidth,
      required this.dialogImgHeight,
      required this.dialogTopText,
      required this.dialogBottomText,
      required this.primaryBtText,
      required this.secondaryBtText,
      required this.primaryBtIsShow,
      required this.secondaryBtIsShow,
      required this.primaryCallback,
      required this.secondaryCallback})
      : super(key: key);
  @override
  State<DialogDrop> createState() => _DialogDropState();
}

class _DialogDropState extends State<DialogDrop> {
  String _selectedItem = '';
  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: widget.dialogWidth,
        height: widget.dialogHeight,
        padding: EdgeInsets.fromLTRB(120, 16, 120, 16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                widget.dialogImg,
                width: widget.dialogImgWidth,
                height: widget.dialogImgHeight,
              ),
              const SizedBox(height: 24),
              Text(
                widget.dialogTopText,
                style: const TextStyle(
                    fontSize: adrFont.subtitle1FontSize,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dialogBottomText,
                    style: const TextStyle(fontSize: adrFont.body2FontSize),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AdDropdownButtonFormField(
                    decoration: const InputDecoration(),
                    items: _dropdownItems.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? selectedItem) {
                      setState(() {
                        _selectedItem = selectedItem!;
                      });
                      print(selectedItem);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 34),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdButtonSecondary(
                      text: widget.secondaryBtText,
                      onPressed: widget.secondaryCallback),
                  _selectedItem == ''
                      ? AdButtonSecondary(
                          text: widget.primaryBtText, onPressed: null)
                      /* FilledButton(
                          onPressed: null, child: Text(widget.primaryBtText)) */
                      : AdButtonPrimary(
                          text: widget.primaryBtText,
                          onPressed: widget.primaryCallback)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
