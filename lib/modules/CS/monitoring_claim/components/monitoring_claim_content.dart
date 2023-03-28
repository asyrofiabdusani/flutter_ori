import 'package:flutter/material.dart';
import 'data_nasabah.dart';

class MonitoringClaimContent extends StatelessWidget {
  const MonitoringClaimContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //? card
        Padding(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: DataNasabah(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
