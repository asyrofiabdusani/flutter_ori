import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';

class DataTableHistoriKlaim extends StatefulWidget {
  const DataTableHistoriKlaim({super.key});

  @override
  State<DataTableHistoriKlaim> createState() => _DataTableHistoriKlaimState();
}

class _DataTableHistoriKlaimState extends State<DataTableHistoriKlaim> {
  final List<Map> _data = [
    {
      'TglPengajuan': "0123456789",
      'JenisAsuransi': 'Kecelakaan',
      'JenisPelaporan': 'Asuransi Kendaraan',
      'JenisKlaim': 'lorem ipsum',
      'PerusahaanAsuransi': "Zurich",
      'StatusKlaim': "Pengajuan Awal",
      'DetailStatus': "lorem ipsum"
    },
    {
      'TglPengajuan': "0123456789",
      'JenisAsuransi': 'Kecelakaan',
      'JenisPelaporan': 'Asuransi Kendaraan',
      'JenisKlaim': 'lorem ipsum',
      'PerusahaanAsuransi': "Zurich",
      'StatusKlaim': "Pengajuan Awal",
      'DetailStatus': "lorem ipsum"
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
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Tgl Pengajuan',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Jenis Asuransi',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Jenis Pelaporan',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Jenis Klaim',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Perusahaan Asuransi',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Status Klaim',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Detail Status',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      const AdDataColumn(
          label: Expanded(
        child: Text(
          'Aksi',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )),
    ];
  }

  List<AdDataRow> _demoCreateRows() {
    return _data
        .mapIndexed((index, data) => AdDataRow(
                cells: [
                  AdDataCell(Text(data['TglPengajuan'])),
                  AdDataCell(Text(data['JenisAsuransi'])),
                  AdDataCell(Text(data['JenisPelaporan'])),
                  AdDataCell(Text(data['JenisKlaim'])),
                  AdDataCell(Text(data['PerusahaanAsuransi'])),
                  AdDataCell(Text(data['StatusKlaim'])),
                  AdDataCell(Text(data['DetailStatus'])),
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
