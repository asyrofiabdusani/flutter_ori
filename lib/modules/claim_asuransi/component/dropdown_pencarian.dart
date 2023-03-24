import 'package:flutter/material.dart';

const List<String> list = <String>['Nama Nasabah', 'Pilihan 2', 'Pilihan 3'];

class DropdownButtonPencarian extends StatefulWidget {
  const DropdownButtonPencarian({super.key});

  @override
  State<DropdownButtonPencarian> createState() =>
      _DropdownButtonPencarianState();
}

class _DropdownButtonPencarianState extends State<DropdownButtonPencarian> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: Colors.blue, style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.blue,
          ),
          style: const TextStyle(color: Colors.grey, fontSize: 14),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
