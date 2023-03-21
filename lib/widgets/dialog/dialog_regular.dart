import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';

class DialogRegular extends StatelessWidget {
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

  const DialogRegular(
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
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                dialogImg,
                width: dialogImgWidth,
                height: dialogImgHeight,
              ),
              const SizedBox(height: 24),
              Text(
                dialogTopText,
                style: const TextStyle(
                    fontSize: adrFont.subtitle1FontSize,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                dialogBottomText,
                style: const TextStyle(fontSize: adrFont.body2FontSize),
              ),
              const SizedBox(height: 34),
              primaryBtIsShow && secondaryBtIsShow
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        secondaryBtIsShow
                            ? AdButtonSecondary(
                                text: secondaryBtText,
                                onPressed: secondaryCallback)
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
