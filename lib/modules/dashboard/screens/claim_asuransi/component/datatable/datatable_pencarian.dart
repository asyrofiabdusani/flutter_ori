import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';

class DataTablePencarian extends StatefulWidget {
  const DataTablePencarian({super.key});

  @override
  State<DataTablePencarian> createState() => _DataTablePencarianState();
}

class _DataTablePencarianState extends State<DataTablePencarian> {
  final List<Map> _data = [
    {
      'NoKontrak': 5324141242,
      'NamaNasabah': 'Ahmad Sobari',
      'status': 'Disetujui',
      'NoBpkb': '1234',
      'NoPolisi': '1234',
      'NoRangka': '1234',
      'NoMesin': '1234',
      'approve': true,
    },
    {
      'NoKontrak': 1238419514,
      'NamaNasabah': 'Caca Marica',
      'status': 'Disetujui',
      'NoBpkb': '1234',
      'NoPolisi': '1234',
      'NoRangka': '1234',
      'NoMesin': '1234',
      'approve': true,
    },
    {
      'NoKontrak': 8865754643,
      'NamaNasabah': 'Bahrun Mishar',
      'status': 'Ditolak',
      'NoBpkb': '1234',
      'NoPolisi': '1234',
      'NoRangka': '1234',
      'NoMesin': '1234',
      'approve': false,
    }
  ];

  List<bool> _selectedTable = [];
  @override
  void initState() {
    super.initState();
    _selectedTable = List<bool>.generate(_data.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return createDataTable();
  }

  AdDataTable createDataTable() {
    return AdDataTable(
      columns: _demoCreateColumns(),
      rows: _demoCreateRows(),
      headingRowColor: MaterialStateProperty.all<Color>(Color(0xFF101828)),
      headingRowHeight: 75,
      headingTextStyle: TextStyle(color: adrColor.textWhite),
      showCheckboxColumn: false,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(adrSize.radiusMedium),
        border:
            Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1),
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(adrSize.radiusMedium),
      //   // border: Border.all(color: Colors.grey),
      // ),
    );
  }

  List<AdDataColumn> _demoCreateColumns() {
    return [
      const AdDataColumn(label: Text('No Kontrak')),
      const AdDataColumn(label: Text('Nama Nasabah')),
      const AdDataColumn(label: Text('Status Kontrak')),
      const AdDataColumn(label: Text('No. Bpkb')),
      const AdDataColumn(label: Text('No. Polisi')),
      const AdDataColumn(label: Text('No. Rangka')),
      const AdDataColumn(label: Text('No. Mesin')),
      const AdDataColumn(label: Text('Aksi')),
    ];
  }

  List<AdDataRow> _demoCreateRows() {
    return _data
        .mapIndexed((index, data) => AdDataRow(
                cells: [
                  AdDataCell(Text(data['NoKontrak'].toString())),
                  AdDataCell(Text(data['NamaNasabah'])),
                  AdDataCell(Text(data['status'])),
                  AdDataCell(Text(data['NoBpkb'])),
                  AdDataCell(Text(data['NoPolisi'])),
                  AdDataCell(Text(data['NoRangka'])),
                  AdDataCell(Text(data['NoMesin'])),
                  AdDataCell(Text("Pilih")),
                ],
                selected: _selectedTable[index],
                onSelectChanged: (bool? selected) {
                  setState(() {
                    _selectedTable[index] = selected!;
                  });
                }))
        .toList();
  }
}
