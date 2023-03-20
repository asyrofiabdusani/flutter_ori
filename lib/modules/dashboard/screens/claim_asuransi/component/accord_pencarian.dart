import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'dropdown_pencarian.dart';
import 'datatable_pencarian.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';

class AccordionPencarian extends StatefulWidget {
  final String title;
  final String content;

  const AccordionPencarian(
      {Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  State<AccordionPencarian> createState() => _AccordionPencarianState();
}

class _AccordionPencarianState extends State<AccordionPencarian> {
  // Show or hide the content
  bool _showContent = true;
  final List<Map> _data = [
    {
      'NoKontrak': 5324141242,
      'NamaNasabah': 'Ahmad Sobari',
      'status': 'Disetujui',
      'approve': true,
    },
    {
      'NoKontrak': 1238419514,
      'NamaNasabah': 'Caca Marica',
      'status': 'Disetujui',
      'approve': true,
    },
    {
      'NoKontrak': 8865754643,
      'NamaNasabah': 'Bahrun Mishar',
      'status': 'Ditolak',
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
    return Container(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            tileColor: Color.fromRGBO(255, 235, 116, 1.0),
            title: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(
                _showContent
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
            ),
          ),
          // Show or hide the content based on the state
          _showContent
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButtonPencarian(),
                          SizedBox(
                            width: 14,
                          ),
                          Container(
                            width: 261,
                            height: 46,
                            child: TextFormField(
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                hintText: "Cari data",
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(width: 14),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Cari",
                                style: TextStyle(
                                    color: adrColor.textButtonPrimary),
                              ),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(76, 46),
                                  backgroundColor: Color(0xFFFFDD00),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )))
                        ],
                      ),
                      SizedBox(height: 24),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: _demoDataTable())
                    ],
                  ),
                )
              : Container()
        ]),
      ),
    );
  }

  AdDataTable _demoDataTable() {
    return AdDataTable(columns: _demoCreateColumns(), rows: _demoCreateRows());
  }

  List<AdDataColumn> _demoCreateColumns() {
    return [
      const AdDataColumn(label: Text('No Kontrak')),
      const AdDataColumn(label: Text('Nama Nasabah')),
      const AdDataColumn(label: Text('Status Klaim')),
      const AdDataColumn(label: Text('Aksi')),
    ];
  }

  List<AdDataRow> _demoCreateRows() {
    return _data
        .mapIndexed((index, data) => AdDataRow(
                cells: [
                  AdDataCell(Text(data['NoKontrak'].toString())),
                  AdDataCell(Text(data['NamaNasabah'])),
                  AdDataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (data['approve'] == true)
                          AdInputChip.success(label: Text(data['status']))
                        else
                          AdInputChip.warning(label: Text(data['status'])),
                      ],
                    ),
                  ),
                  AdDataCell(Row(
                    children: [
                      AdButtonText(text: ('Button 1'), onPressed: () {}),
                      AdButtonText(
                        text: ('Delete'),
                        onPressed: () {},
                        danger: true,
                      ),
                      AdButtonIcon(
                        icon: Icons.delete,
                        onPressed: () => print(data),
                        danger: true,
                      ),
                    ],
                  ))
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
