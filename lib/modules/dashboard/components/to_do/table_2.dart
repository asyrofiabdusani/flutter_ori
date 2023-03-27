import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';

List<DataColumn> headDataColumnSecond() {
  return [
    DataColumn(
      label: const Text(
        'No. Kontrak',
        style: TextStyle(color: adrColor.textWhite),
      ),
      onSort: (columnIndex, ascending) {
        print("$columnIndex $ascending");
      },
    ),
    const DataColumn(
      label: Text('Nama Nasabah', style: TextStyle(color: adrColor.textWhite)),
    ),
    const DataColumn(
      label: Text('Perusahaan Asuransi',
          style: TextStyle(color: adrColor.textWhite)),
    ),
    const DataColumn(
      label: Text('Status Klaim', style: TextStyle(color: adrColor.textWhite)),
    ),
    const DataColumn(
      label:
          Text('Sub Status Klaim', style: TextStyle(color: adrColor.textWhite)),
    ),
    const DataColumn(
      label: Text('Aksi', style: TextStyle(color: adrColor.textWhite)),
    ),
  ];
}

class TableRowSecond extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(TextButton(onPressed: () {}, child: Text('Lihat Detail'))),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}
