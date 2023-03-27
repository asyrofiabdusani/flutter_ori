import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';

List<DataColumn> headDataColumnFirst() {
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
      label:
          Text('Jenis Pelaporan', style: TextStyle(color: adrColor.textWhite)),
    ),
    const DataColumn(
      label: Text('Aksi', style: TextStyle(color: adrColor.textWhite)),
    ),
  ];
}

class TableRowFirst extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      const DataCell(Text("Pilih")),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}