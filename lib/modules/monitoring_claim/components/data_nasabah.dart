import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_ori/widgets/table/paginated_3.dart';
import '../../../tokens/aether.dart';

class DataNasabah extends StatefulWidget {
  const DataNasabah({super.key});

  @override
  State<DataNasabah> createState() => _DataNasabahState();
}

class _DataNasabahState extends State<DataNasabah> {
  @override
  Widget build(BuildContext context) {
    String _selectedItem = 'Item 1';
    final List<String> _dropdownItems = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
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
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                    child: AdDropdownButtonFormField(
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
                  ),
                  Expanded(
                    child: AdDropdownButtonFormField(
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
                  ),
                  Expanded(
                    child: AdDropdownButtonFormField(
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
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24, top: 24),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton(
                    onPressed: () {},
                    child: const Text(
                      adrText.main_dashboard_to_do_list1,
                      style: TextStyle(fontSize: 12),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          adrColor.backgroundPrimaryContainer),
                      foregroundColor:
                          MaterialStatePropertyAll(adrColor.textButtonPrimary),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              width: 1, color: adrColor.backgroundPrimary),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton(
                  onPressed: () {},
                  child: const Text(
                    adrText.main_dashboard_to_do_list6,
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(adrColor.backgroundBaseLight),
                    foregroundColor:
                        MaterialStatePropertyAll(adrColor.textButtonPrimary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(width: 1, color: adrColor.borderBase),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const PaginatedThird(),
      ],
    );
  }
}
