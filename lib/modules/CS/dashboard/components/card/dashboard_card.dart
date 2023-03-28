import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/widgets/card/card_1.dart';

class DashboardCard extends StatelessWidget {
  final String cardTitle;
  final int cardTotal;
  final int cardColor;

  const DashboardCard(
      {super.key,
      required this.cardTitle,
      required this.cardTotal,
      required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 188,
        child: CardFirst(
            cardTitle: cardTitle, cardTotal: cardTotal, cardColor: cardColor));
  }
}
