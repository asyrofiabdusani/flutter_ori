import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/widgets/timeline/tile/timeline_tile.dart';

class AdTimeLine extends StatelessWidget {
  const AdTimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdTimelineTile(
          time: "15 Des 11.26",
          msg: ["Pengajuan Ditolak", "Pengajuan Ditolak"],
          isFirst: true,
        ),
        AdTimelineTile(
          time: "15 Des 11.26",
          msg: ["Pengajuan Ditolak", ""],
          isFirst: false,
        ),
        AdTimelineTile(
          time: "15 Des 11.26",
          msg: ["Pengajuan Ditolak", ""],
          isFirst: false,
        ),
      ],
    );
  }
}
