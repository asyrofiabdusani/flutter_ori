import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';

class FormPengajuanKlaim extends StatefulWidget {
  const FormPengajuanKlaim({super.key});

  @override
  State<FormPengajuanKlaim> createState() => _FormPengajuanKlaimState();
}

class _FormPengajuanKlaimState extends State<FormPengajuanKlaim> {
  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String _selectedItem = 'Item 1';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! Pengajuan Claim
        Text(
          "Pengajuan Klaim",
          style: TextStyle(
              fontSize: adrFont.h4FontSize, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.date_range_outlined),
                      hintText: "Tanggal Pengajuan",
                      labelText: "Tanggal Pengajuan",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis Asuransi",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AdDropdownButtonFormField(
                        hint: Text("Jenis Asuransi"),
                        decoration: const InputDecoration(
                          labelText: "Jenis Asuransi",
                          border: OutlineInputBorder(),

                          // prefixText: 'pref',
                          // prefixIcon: Icon(Icons.abc),
                          // prefix: Text('pref'),
                          // suffix: Text('suff'),
                          // suffixIcon: Icon(Icons.abc),
                          // suffixText: 'suff',
                        ),
                        items: _dropdownItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedItem = selectedItem!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "Perusahaan Asuransi",
                      labelText: "Perusahaan Asuransi",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis KLaim",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AdDropdownButtonFormField(
                        hint: Text("Jenis Klaim"),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // prefixText: 'pref',
                          // prefixIcon: Icon(Icons.abc),
                          // prefix: Text('pref'),
                          // suffix: Text('suff'),
                          // suffixIcon: Icon(Icons.abc),
                          // suffixText: 'suff',
                        ),
                        items: _dropdownItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedItem = selectedItem!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis Pelaporan Klaim",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AdDropdownButtonFormField(
                        hint: Text("Jenis Pelaporan Klaim"),
                        decoration: const InputDecoration(
                          labelText: "Jenis Pelaporan Klaim",
                          border: OutlineInputBorder(),

                          // prefixText: 'pref',
                          // prefixIcon: Icon(Icons.abc),
                          // prefix: Text('pref'),
                          // suffix: Text('suff'),
                          // suffixIcon: Icon(Icons.abc),
                          // suffixText: 'suff',
                        ),
                        items: _dropdownItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedItem = selectedItem!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 85,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // ! Kronologi Kejadian
        SizedBox(
          height: 48,
        ),
        Text(
          "Kronologi Kejadian",
          style: TextStyle(
              fontSize: adrFont.h4FontSize, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.date_range_outlined),
                      hintText: "Select Date",
                      labelText: "Tanggal Kejadian",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Laporan Polisi",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AdDropdownButtonFormField(
                        hint: Text("Laporan Polisi"),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // prefixText: 'pref',
                          // prefixIcon: Icon(Icons.abc),
                          // prefix: Text('pref'),
                          // suffix: Text('suff'),
                          // suffixIcon: Icon(Icons.abc),
                          // suffixText: 'suff',
                        ),
                        items: _dropdownItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedItem = selectedItem!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AdTextFormField(
                        decoration: InputDecoration(
                          hintText: "Nama Saksi",
                          labelText: "Nama Saksi",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AdTextFormField(
                        decoration: InputDecoration(
                          hintText: "Alamat Saksi",
                          labelText: "Alamat Saksi",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AdTextFormField(
                        decoration: InputDecoration(
                          hintText: "Nama Saksi",
                          labelText: "PIC Penerima Pelaporan Klaim",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "Tempat Kejadian",
                      labelText: "Tempat Kejadian",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      labelText: "No. Telpon (Optional)",
                      hintText: "081111111111",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "Pelaporan Klaim",
                      labelText: "Pelaporan Klaim",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: "Kronologi Kejadian",
                      labelText: "Kronologi Kejadian",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
