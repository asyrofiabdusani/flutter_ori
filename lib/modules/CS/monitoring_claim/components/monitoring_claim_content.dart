import 'package:flutter/material.dart';
import 'data_nasabah_search.dart';
import 'package:flutter_ori/widgets/table/styled_paginated_table.dart';
import 'table_monitoring.dart';

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
                child: Column(
                  children: [
                    const DataNasabahSearch(),
                    StyledPaginatedTable(
                        columns: headDataColumnMonitoring(),
                        rows: TableRowMonitoring(),
                        rowPerPage: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
