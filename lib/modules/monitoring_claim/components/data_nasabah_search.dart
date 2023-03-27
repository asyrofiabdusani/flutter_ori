import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_ori/widgets/dialog/dialog_checklist.dart';
import 'package:flutter_ori/widgets/dialog/dialog_text_area.dart';
import '../../../tokens/aether.dart';
import 'package:intl/intl.dart';

final List<String> dropdownArea = [
  'Area 1',
  'Area 2',
];
final List<String> dropdownCabang = [
  'Cabang 1',
  'Cabang 2',
];
final List<String> dropdownPkStruktur = [
  'Drop Down 1',
  'Drop Down 2',
];
final List<String> dropdownPerusahaan = [
  'Perusahaan 1',
  'Perusahaan 2',
];
final List<String> dropdownGroupKlaim = [
  'Group Klaim 1',
  'Group Klaim 2',
];
final List<String> dropdownStatusKlaim = [
  'Status Klaim 1',
  'Status Klaim 2',
];

class DataNasabahSearch extends StatefulWidget {
  const DataNasabahSearch({super.key});

  @override
  State<DataNasabahSearch> createState() => _DataNasabahSearchState();
}

class _DataNasabahSearchState extends State<DataNasabahSearch> {
  String date = '';
  String selectedArea = '';
  String selectedCabang = '';
  String selectedPkStruktur = '';
  String selectedPerusahaan = '';
  String selectedGroupKlaim = '';
  String selectedStatusKlaim = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Nasabah',
          style: TextStyle(
              fontSize: adrFont.h2FontSize, fontWeight: FontWeight.w600),
        ),
        Column(
          children: [
            //? textfield first row
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                    child: AdDropdownButtonFormField(
                      hint: const Text('Area'),
                      items: dropdownArea.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedArea = selectedItem!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: AdDropdownButtonFormField(
                      hint: const Text('Cabang'),
                      items: dropdownCabang.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedCabang = selectedItem!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: AdTextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Nama Nasabah/No. Polisi/No. Kontrak'),
                    ),
                  ),
                ],
              ),
            ),
            //? textfield second row
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AdDropdownButtonFormField(
                      hint: const Text('PK Restructure'),
                      items: dropdownPkStruktur.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedPkStruktur = selectedItem!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: AdDropdownButtonFormField(
                      hint: const Text('Perusahaan Asuransi'),
                      items: dropdownPerusahaan.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedPerusahaan = selectedItem!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: AdTextFormField(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary:
                                        adrColor.backgroundPrimaryContainer,
                                    onPrimary: adrColor.textNormal),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      primary: adrColor
                                          .textNormal // button text color
                                      ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyy').format(pickedDate);
                          setState(() {
                            date = formattedDate;
                          });
                        }
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: date == '' ? 'Tanggal Pengajuan' : date,
                        hintStyle: TextStyle(
                            color: date == ''
                                ? const Color(0xff666666)
                                : adrColor.textNormal),
                        suffixIcon: const Icon(Icons.date_range),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //? textfield third row
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AdDropdownButtonFormField(
                      hint: const Text('Group Klaim'),
                      items: dropdownGroupKlaim.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedGroupKlaim = selectedItem!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: AdDropdownButtonFormField(
                      hint: const Text('Status Klaim'),
                      items: dropdownStatusKlaim.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedStatusKlaim = selectedItem!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24, top: 24),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton(
                  onPressed: () {
                    print(selectedArea);
                    setState(() {
                      selectedArea = '';
                    });
                    print(selectedArea);
                  },
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(24, 8, 24, 8)),
                    backgroundColor: const MaterialStatePropertyAll(
                        adrColor.backgroundBaseLight),
                    foregroundColor: const MaterialStatePropertyAll(
                        adrColor.textButtonPrimary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                            width: 1, color: adrColor.borderError),
                      ),
                    ),
                  ),
                  child: const Text(
                    adrText.button_reset,
                    style: TextStyle(
                      fontSize: adrFont.button1FontSize,
                      fontWeight: FontWeight.w600,
                      color: adrColor.textError,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogChecklist(
                          dialogWidth: 423,
                          dialogHeight: 256,
                          dialogTitle:
                              'Pastikan Anda sudah melakukan pengecekan',
                          dialogFirstChecklist: 'Hasil Klaim',
                          dialogSecondChecklist: 'Surat Keputusan Klaim',
                          dialogThirdChecklist: 'Nilai Pencairan',
                          primaryBtText: 'Approve',
                          secondaryBtText: 'Reject',
                          primaryBtIsShow: true,
                          secondaryBtIsShow: true,
                          primaryCallback: () {},
                          secondaryCallback: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DialogTextArea(
                                  dialogWidth: 522,
                                  dialogHeight: 280,
                                  dialogTitle: 'Keterangan Reject',
                                  dialogLabel: 'Alasan reject',
                                  dialogTextHint: 'Isi Keterangan',
                                  dialogMaxLines: 7,
                                  primaryBtText: 'Submit Catatan',
                                  secondaryBtText: 'Kembali',
                                  primaryBtIsShow: true,
                                  secondaryBtIsShow: true,
                                  primaryCallback: () {},
                                  secondaryCallback: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(24, 8, 24, 8)),
                    backgroundColor: const MaterialStatePropertyAll(
                        adrColor.backgroundPrimary),
                    foregroundColor: const MaterialStatePropertyAll(
                        adrColor.textButtonPrimary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                            width: 1, color: adrColor.backgroundPrimary),
                      ),
                    ),
                  ),
                  child: const Text(
                    adrText.button_cari,
                    style: TextStyle(
                      fontSize: adrFont.button1FontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DatePick extends StatefulWidget {
  const DatePick({super.key});

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
