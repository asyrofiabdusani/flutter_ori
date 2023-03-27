import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';

class DialogChecklist extends StatefulWidget {
  final double dialogWidth;
  final double dialogHeight;
  final String dialogTitle;
  final String dialogFirstChecklist;
  final String dialogSecondChecklist;
  final String dialogThirdChecklist;
  final String primaryBtText;
  final String secondaryBtText;
  final bool primaryBtIsShow;
  final bool secondaryBtIsShow;
  final VoidCallback primaryCallback;
  final VoidCallback secondaryCallback;

  const DialogChecklist(
      {Key? key,
      required this.dialogWidth,
      required this.dialogHeight,
      required this.dialogTitle,
      required this.dialogFirstChecklist,
      required this.dialogSecondChecklist,
      required this.dialogThirdChecklist,
      required this.primaryBtText,
      required this.secondaryBtText,
      required this.primaryBtIsShow,
      required this.secondaryBtIsShow,
      required this.primaryCallback,
      required this.secondaryCallback})
      : super(key: key);

  @override
  State<DialogChecklist> createState() => _DialogChecklistState();
}

class _DialogChecklistState extends State<DialogChecklist> {
  bool firstCheckbox = false;
  bool secondCheckbox = false;
  bool thirdCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: widget.dialogWidth,
          height: widget.dialogHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.dialogTitle,
                style: const TextStyle(
                    fontSize: adrFont.subtitle2FontSize,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Divider(),
              ),
              AdCheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Item 1',
                  style: TextStyle(fontSize: adrFont.body2FontSize),
                ),
                value: firstCheckbox,
                onChanged: (bool? value) {
                  setState(
                    () {
                      firstCheckbox = value!;
                    },
                  );
                },
              ),
              AdCheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Item 2',
                  style: TextStyle(fontSize: adrFont.body2FontSize),
                ),
                value: secondCheckbox,
                onChanged: (bool? value) {
                  setState(
                    () {
                      secondCheckbox = value!;
                    },
                  );
                },
              ),
              AdCheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Item 3',
                  style: TextStyle(fontSize: adrFont.body2FontSize),
                ),
                value: thirdCheckbox,
                onChanged: (bool? value) {
                  setState(
                    () {
                      thirdCheckbox = value!;
                    },
                  );
                },
              ),
              const SizedBox(height: 14),
              widget.primaryBtIsShow && widget.secondaryBtIsShow
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.secondaryBtIsShow
                            ? Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: AdButtonSecondary(
                                    text: widget.secondaryBtText,
                                    onPressed: widget.secondaryCallback),
                              )
                            : Container(),
                        widget.primaryBtIsShow
                            ? AdButtonPrimary(
                                text: widget.primaryBtText,
                                onPressed: widget.primaryCallback)
                            : Container()
                      ],
                    )
                  : Container(
                      child: (widget.primaryBtIsShow
                          ? AdButtonPrimary(
                              text: widget.primaryBtText,
                              onPressed: widget.primaryCallback)
                          : AdButtonSecondary(
                              text: widget.secondaryBtText,
                              onPressed: widget.secondaryCallback)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
