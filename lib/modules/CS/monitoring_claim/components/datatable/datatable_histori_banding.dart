import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/widgets/table/styled_paginated_table.dart';

class DataTableHistoriBanding extends StatefulWidget {
  const DataTableHistoriBanding({super.key});

  @override
  State<DataTableHistoriBanding> createState() =>
      _DataTableHistoriBandingState();
}

class _DataTableHistoriBandingState extends State<DataTableHistoriBanding> {
  @override
  Widget build(BuildContext context) {
    return createDataTable();
  }

  StyledPaginatedTable createDataTable() {
    return StyledPaginatedTable(
        columns: _CreateColumns(), rows: TableRow(), rowPerPage: 5);
  }

  List<DataColumn> _CreateColumns() {
    return [
      const DataColumn(
          label: Text(
        'Banding',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'Tgl Pengajuan',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'Alasan banding',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'Aksi',
        style: TextStyle(color: adrColor.textWhite),
      )),
    ];
  }
}

class TableRow extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Pilih")),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}
