import 'package:flutter/material.dart';

DataTable createDataTable() {
  return DataTable(
    columns: _createColumns(),
    rows: _createRows(),
    border: TableBorder.all(
        borderRadius: BorderRadius.circular(8), color: Colors.black),
    headingTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    headingRowColor:
        MaterialStateProperty.resolveWith((states) => Colors.black),
  );
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(
        label: Text(
      'No. Kontrak',
      style: TextStyle(overflow: TextOverflow.ellipsis),
    )),
    DataColumn(
        label: Text(
      'Nama Nasabah',
      style: TextStyle(overflow: TextOverflow.ellipsis),
    )),
    DataColumn(
        label: Text(
      'Status Kontrak',
      style: TextStyle(overflow: TextOverflow.ellipsis),
    )),
    DataColumn(
        label: Text(
      'No.Bpkb',
      style: TextStyle(overflow: TextOverflow.ellipsis),
    )),
    DataColumn(
        label: Text(
      'No.Polisi',
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
      ),
    )),
    DataColumn(
        label: Text(
      'No.Rangka',
      style: TextStyle(overflow: TextOverflow.ellipsis),
    )),
    DataColumn(
        label: Text(
      'No.Aksi',
      style: TextStyle(overflow: TextOverflow.ellipsis),
    )),
  ];
}

List<DataRow> _createRows() {
  return [
    DataRow(cells: [
      DataCell(Text('#100')),
      DataCell(Text('Flutter Basics')),
      DataCell(Text('David John')),
      DataCell(Text('David John')),
      DataCell(Text('David John')),
      DataCell(Text('David John')),
      DataCell(Text('David John')),
    ]),
  ];
}
