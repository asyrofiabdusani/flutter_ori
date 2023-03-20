import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_ori/widgets/card/card.dart';

class CardContent extends StatelessWidget {
  final String cardTitle;
  final int cardTotal;
  final int cardColor;

  const CardContent(
      {required this.cardTitle,
      required this.cardTotal,
      required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      child: Card(
        color: Color(cardColor),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${cardTitle}',
                style: TextStyle(
                    fontSize: adrFont.h4FontSize, color: Colors.white),
              ),
              Text(
                '${cardTotal}',
                style: TextStyle(
                    fontSize: 64,
                    color: adrColor.textWhite,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: adrColor.textWhite,
                  padding: const EdgeInsets.all(0),
                  textStyle:
                      const TextStyle(fontSize: adrFont.subtitle2FontSize),
                ),
                onPressed: () {},
                child: const Text(adrText.main_dashboard_selengkapnya),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
