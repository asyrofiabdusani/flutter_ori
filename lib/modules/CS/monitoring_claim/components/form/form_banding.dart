import 'package:flutter/material.dart';
import 'package:flutter_ori/widgets/form/form_date_picker.dart';
import 'package:flutter_ori/widgets/form/form_pick_file.dart';
import 'package:flutter_ori/tokens/aether.dart';

class FormBanding extends StatefulWidget {
  const FormBanding({super.key});

  @override
  State<FormBanding> createState() => _FormBandingState();
}

class _FormBandingState extends State<FormBanding> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormDatePicker(hint: "Tgl Kirim", label: "Tanggal Pengajuan"),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: FormFilePicker(
                label: "COPY KTP / SIM DEBITUR *",
                hint: "File JPG, PNG, PDF, Docx",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: AdTextFormField(
                decoration: InputDecoration(
                  hintText: "Keterangan",
                  labelText: "Keterangan",
                ),
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
              child: FormFilePicker(
                label: "FORM PELAPORAN KLAIM *",
                hint: "File JPG, PNG, PDF, Docx",
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: AdTextFormField(
                decoration: InputDecoration(
                  hintText: "Keterangan",
                  labelText: "Keterangan",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        AdTextFormField(
          maxLines: 7,
          decoration: InputDecoration(
            hintText: "Alasan",
            labelText: "Alasan Pengajuan Banding",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AdButtonSecondary(
              text: "Batal",
              onPressed: () {},
              danger: true,
            ),
            SizedBox(
              width: 24,
            ),
            AdButtonPrimary(text: "Ajukan Banding", onPressed: () {}),
          ],
        )
      ],
    );
  }
}
