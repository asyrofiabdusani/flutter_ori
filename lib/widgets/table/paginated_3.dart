import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';

class PaginatedThird extends StatelessWidget {
  const PaginatedThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          cardColor: Colors.transparent,
          cardTheme: const CardTheme(elevation: 0),
          dividerColor: adrColor.borderBase),
      child: Stack(
        children: [
          Container(
            height: 98,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: adrColor.borderBase),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Transform.scale(
              scaleX: 1.01,
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  initialFirstRowIndex: 0,
                  rowsPerPage: 5,
                  availableRowsPerPage: const [],
                  headingRowHeight: 93,
                  columns: <DataColumn>[
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
                      label: Text('Nama Nasabah',
                          style: TextStyle(color: adrColor.textWhite)),
                    ),
                    const DataColumn(
                      label: Text('Perusahaan Asuransi',
                          style: TextStyle(color: adrColor.textWhite)),
                    ),
                    const DataColumn(
                      label: Text('Jenis Pelaporan',
                          style: TextStyle(color: adrColor.textWhite)),
                    ),
                    const DataColumn(
                      label: Text('Status Klaim',
                          style: TextStyle(color: adrColor.textWhite)),
                    ),
                    const DataColumn(
                      label: Text('Sub Status Klaim',
                          style: TextStyle(color: adrColor.textWhite)),
                    ),
                    const DataColumn(
                      label: Text('Aksi',
                          style: TextStyle(color: adrColor.textWhite)),
                    ),
                  ],
                  source: TableRow(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
