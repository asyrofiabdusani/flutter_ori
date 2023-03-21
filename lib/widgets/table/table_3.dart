import 'package:flutter/material.dart';

class TableThird extends StatelessWidget {
  const TableThird({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(
              width: 1,
              borderRadius: BorderRadius.circular(10),
            ),
            headingRowHeight: 98,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'No. Kontrak',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Nama Nasabah',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Perusahaan Asuransi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Jenis Pelaporan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Tgl Pengajuan Status Klaim',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Status Klaim',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Sub Status Klaim',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Aksi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sarah')),
                  DataCell(Text('19')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sarah')),
                  DataCell(Text('19')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sarah')),
                  DataCell(Text('19')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sarah')),
                  DataCell(Text('19')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sarah')),
                  DataCell(Text('19')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                  DataCell(Text('Student')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
