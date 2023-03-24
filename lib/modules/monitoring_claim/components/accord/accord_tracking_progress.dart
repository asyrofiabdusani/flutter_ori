import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/widgets/timeline/timeline.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter_ori/modules/claim_asuransi/components/form/form_data_nasabah.dart';

class AccordionTrackingProgress extends StatefulWidget {
  const AccordionTrackingProgress({Key? key}) : super(key: key);
  @override
  State<AccordionTrackingProgress> createState() =>
      _AccordionTrackingProgressState();
}

class _AccordionTrackingProgressState extends State<AccordionTrackingProgress> {
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
              child: AdTimeLine(),
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
