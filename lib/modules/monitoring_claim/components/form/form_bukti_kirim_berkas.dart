import 'package:flutter/material.dart';
import 'package:flutter_ori/widgets/form/form_date_picker_checkbox.dart';
import 'package:flutter_ori/widgets/form/form_date_picker.dart';
import 'package:flutter_ori/widgets/form/form_pick_file.dart';
import 'package:flutter_ori/tokens/aether.dart';

class FormBuktiKirimBerkas extends StatefulWidget {
  const FormBuktiKirimBerkas({super.key});

  @override
  State<FormBuktiKirimBerkas> createState() => _FormBuktiKirimBerkasState();
}

class _FormBuktiKirimBerkasState extends State<FormBuktiKirimBerkas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 34,
        ),
        Text(
          "Dokumen Awal",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 34,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Tanggal Kirim",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text("Tanggal Terima",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "COPY KTP / SIM DEBITUR",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormDatePickerCbox(
                label: "FORM PELAPORAN KLAIM",
                hint: "Tgl Kirim",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: FormDatePicker(
                label: " ",
                hint: "Tgl Terima",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AdButtonPrimary(text: "Simpan Bukti Kirim", onPressed: () {}),
          ],
        )
      ],
    );
  }
}
