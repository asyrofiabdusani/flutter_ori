import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/widgets/table/styled_paginated_table.dart';

class DataTablePencarian extends StatefulWidget {
  const DataTablePencarian({super.key});

  @override
  State<DataTablePencarian> createState() => _DataTablePencarianState();
}

class _DataTablePencarianState extends State<DataTablePencarian> {
  @override
  Widget build(BuildContext context) {
    return createDataTable();
  }

  // AdDataTable createDataTable() {
  //   return AdDataTable(
  //     columns: _demoCreateColumns(),
  //     rows: _demoCreateRows(),
  //     headingRowColor: MaterialStateProperty.all<Color>(Color(0xFF101828)),
  //     headingRowHeight: 75,
  //     headingTextStyle: TextStyle(color: adrColor.textWhite),
  //     showCheckboxColumn: false,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(adrSize.radiusMedium),
  //       border:
  //           Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1),
  //     ),
  //     // decoration: BoxDecoration(
  //     //   borderRadius: BorderRadius.circular(adrSize.radiusMedium),
  //     //   // border: Border.all(color: Colors.grey),
  //     // ),
  //   );
  // }

  StyledPaginatedTable createDataTable() {
    return StyledPaginatedTable(
        columns: _CreateColumns(), rows: TableRow(), rowPerPage: 5);
  }

  List<DataColumn> _CreateColumns() {
    return [
      const DataColumn(
          label: Text(
        'No Kontrak',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'Nama Nasabah',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'Status Kontrak',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'No. Bpkb',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'No. Polisi',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'No. Rangka',
        style: TextStyle(color: adrColor.textWhite),
      )),
      const DataColumn(
          label: Text(
        'No. Mesin',
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
      DataCell(Text("Cell $index")),
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
