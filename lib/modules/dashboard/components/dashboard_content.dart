
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_ori/widgets/card/card.dart';
import './to_do.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //? card
        Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            children: const [
              Expanded(
                flex: 1,
                child: CardContent(
                    cardTitle: adrText.main_dashboard_card_title_1,
                    cardTotal: 20,
                    cardColor: 0xff5348AB),
              ),
              Expanded(
                flex: 1,
                child: CardContent(
                    cardTitle: adrText.main_dashboard_card_title_2,
                    cardTotal: 20,
                    cardColor: 0xff12B76A),
              ),
              Expanded(
                flex: 1,
                child: CardContent(
                    cardTitle: adrText.main_dashboard_card_title_3,
                    cardTotal: 20,
                    cardColor: 0xffF79009),
              ),
              Expanded(
                flex: 1,
                child: CardContent(
                    cardTitle: adrText.main_dashboard_card_title_4,
                    cardTotal: 20,
                    cardColor: 0xff175CD3),
              ),
            ],
          ),
        ),
        //? To Do
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ToDoWg(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
