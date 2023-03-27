import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';

class FormDatePickerCbox extends StatefulWidget {
  final String hint;
  final String label;
  const FormDatePickerCbox(
      {super.key, required this.hint, required this.label});

  @override
  State<FormDatePickerCbox> createState() => _FormDatePickerCboxState();
}

class _FormDatePickerCboxState extends State<FormDatePickerCbox> {
  @override
  Widget build(BuildContext context) {
    return AdTextFormField(
      onTap: () => showDatePicker(
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                        onPrimary: Color(0xFF101828),
                        primary: adrColor.backgroundPrimaryContainer),
                    textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                      primary: Color(0xFF101828),
                    ))),
                child: child!);
          },
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1970),
          lastDate: DateTime(3000)),
      decoration: InputDecoration(
        icon: Checkbox(value: false, onChanged: (value) {}),
        suffixIcon: Icon(Icons.date_range_outlined),
        hintText: widget.hint,
        labelText: widget.label,
      ),
    );
  }
}
