import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';

class DataTableJenisAsuransi extends StatefulWidget {
  const DataTableJenisAsuransi({super.key});

  @override
  State<DataTableJenisAsuransi> createState() => _DataTableJenisAsuransiState();
}

class _DataTableJenisAsuransiState extends State<DataTableJenisAsuransi> {
  final List<Map> _data = [
    {
      'JenisAsuransi': "36 TOTAL LOSS ONLY (TLO)",
      'PeriodeAsuransi': 'Ahmad Sobari',
      'Perusahaan': 'Disetujui',
    },
    {
      'JenisAsuransi': "KECELAKAAN DIRI (PA)",
      'PeriodeAsuransi': 'Caca Marica',
      'Perusahaan': 'Disetujui',
    },
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
      const AdDataColumn(label: Text('Jenis Asuransi')),
      const AdDataColumn(label: Text('Periode Asuransi')),
      const AdDataColumn(label: Text('Perusahaan Asuransi')),
      const AdDataColumn(label: Text('Aksi')),
    ];
  }

  List<AdDataRow> _demoCreateRows() {
    return _data
        .mapIndexed((index, data) => AdDataRow(
                cells: [
                  AdDataCell(Text(data['JenisAsuransi'])),
                  AdDataCell(Text(data['PeriodeAsuransi'])),
                  AdDataCell(Text(data['Perusahaan'])),
                  AdDataCell(Text("Upgrade")),
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
