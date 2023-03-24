import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';

class AdTimelineTile extends StatelessWidget {
  String time;
  List<String> msg = ["", ""];
  bool? isActive = false;
  bool isFirst = false;
  AdTimelineTile(
      {super.key,
      required this.time,
      required this.msg,
      this.isActive,
      required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      indicatorStyle: IndicatorStyle(
          color: adrColor.textSuccess,
          iconStyle: IconStyle(iconData: Icons.check)),
      isFirst: isFirst,
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      startChild: Container(
        padding: EdgeInsets.only(right: 50),
        alignment: Alignment.centerRight,
        constraints: BoxConstraints(
          minHeight: msg[1] == "" ? 80 : 100,
        ),
        // color: Colors.lightGreenAccent,
        child: const Text(
          "12 Des 11.26",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: adrColor.textSuccess,
            fontSize: 14,
          ),
        ),
      ),
      endChild: Container(
        padding: EdgeInsets.only(left: 50, top: 15),
        alignment: Alignment.centerLeft,
        // color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(msg[0],
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: adrColor.textSuccess,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(msg[1],
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: adrColor.textSuccess,
                    fontSize: 14,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
