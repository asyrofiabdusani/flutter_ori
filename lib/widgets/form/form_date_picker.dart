import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter/material.dart';

class FormDatePicker extends StatefulWidget {
  const FormDatePicker({super.key});

  @override
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => "",
      child: AdTextFormField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.date_range_outlined),
          hintText: "Tanggal Pengajuan",
          labelText: "Tanggal Pengajuan",
        ),
      ),
    );
  }
}
