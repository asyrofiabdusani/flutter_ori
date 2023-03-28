import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/datatable/datatable_histori_banding.dart';

class AccordionHistoriBanding extends StatefulWidget {
  const AccordionHistoriBanding({Key? key}) : super(key: key);
  @override
  State<AccordionHistoriBanding> createState() =>
      _AccordionHistoriBandingState();
}

class _AccordionHistoriBandingState extends State<AccordionHistoriBanding> {
  // Show or hide the content
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Tracking Progress",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: DataTableHistoriBanding(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
