import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';

class DialogTextArea extends StatelessWidget {
  final double dialogWidth;
  final double dialogHeight;
  final String dialogTitle;
  final String dialogLabel;
  final String dialogTextHint;
  final int dialogMaxLines;
  final String primaryBtText;
  final String secondaryBtText;
  final bool primaryBtIsShow;
  final bool secondaryBtIsShow;
  final VoidCallback primaryCallback;
  final VoidCallback secondaryCallback;

  const DialogTextArea(
      {Key? key,
      required this.dialogWidth,
      required this.dialogHeight,
      required this.dialogTitle,
      required this.dialogLabel,
      required this.dialogTextHint,
      required this.dialogMaxLines,
      required this.primaryBtText,
      required this.secondaryBtText,
      required this.primaryBtIsShow,
      required this.secondaryBtIsShow,
      required this.primaryCallback,
      required this.secondaryCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: dialogWidth,
          height: dialogHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                dialogTitle,
                style: const TextStyle(
                    fontSize: adrFont.subtitle2FontSize,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Divider(),
              ),
              AdTextFormField(
                maxLines: dialogMaxLines,
                decoration: InputDecoration(
                  label: Text(
                    dialogLabel,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  hintStyle: TextStyle(fontSize: 1),
                  hintText: dialogTextHint,
                ),
              ),
              const SizedBox(height: 14),
              primaryBtIsShow && secondaryBtIsShow
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        secondaryBtIsShow
                            ? Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: AdButtonSecondary(
                                    text: secondaryBtText,
                                    onPressed: secondaryCallback),
                              )
                            : Container(),
                        primaryBtIsShow
                            ? AdButtonPrimary(
                                text: primaryBtText, onPressed: primaryCallback)
                            : Container()
                      ],
                    )
                  : Container(
                      child: (primaryBtIsShow
                          ? AdButtonPrimary(
                              text: primaryBtText, onPressed: primaryCallback)
                          : AdButtonSecondary(
                              text: secondaryBtText,
                              onPressed: secondaryCallback)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
