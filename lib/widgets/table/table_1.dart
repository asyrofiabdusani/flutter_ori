import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';

class TableFirst extends StatelessWidget {
  const TableFirst({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: adrColor.borderBase),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              headingRowColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              headingTextStyle: const TextStyle(color: Colors.white),
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
                      'Aksi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  color: MaterialStatePropertyAll(Colors.white),
                  cells: <DataCell>[
                    DataCell(Text('Sarah')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                  ],
                ),
                DataRow(
                  color: MaterialStatePropertyAll(Colors.white),
                  cells: <DataCell>[
                    DataCell(Text('Sarah')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                  ],
                ),
                DataRow(
                  color: MaterialStatePropertyAll(Colors.white),
                  cells: <DataCell>[
                    DataCell(Text('Sarah')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                  ],
                ),
                DataRow(
                  color: MaterialStatePropertyAll(Colors.white),
                  cells: <DataCell>[
                    DataCell(Text('Sarah')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                  ],
                ),
                DataRow(
                  color: MaterialStatePropertyAll(Colors.white),
                  cells: <DataCell>[
                    DataCell(Text('Sarah')),
                    DataCell(Text('19')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                    DataCell(Text('Student')),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Text('paginations'),
          ),
        ],
      ),
    );
  }
}
