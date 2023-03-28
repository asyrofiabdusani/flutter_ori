import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/widgets/form/form_pick_file.dart';

class FormDokumenKlaim extends StatefulWidget {
  const FormDokumenKlaim({super.key});

  @override
  State<FormDokumenKlaim> createState() => _FormDokumenKlaimState();
}

class _FormDokumenKlaimState extends State<FormDokumenKlaim> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! Pengajuan Awal
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
        Column(
          children: [
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
            )
          ],
        ),
        // ! Dokumen Lanjutan
        SizedBox(
          height: 48,
        ),
        Text(
          "Dokumen Lanjutan",
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
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FormFilePicker(
                    label: "FORM PELAPORAN KERUGIAN KLAIM",
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
                    label: "FORM ABANDONMENT",
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
                    label: "LAPORAN POLISI / STPL",
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
                    label: "STNK",
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
                    label: "KUNCI KONTAK",
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
                    label: "COPY SIM PENGEMUDI",
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
                    label: "ESTIMASI KERUSAKAN DARI BENGKEL",
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
                    label: "LAPORAN POLISI / STPL",
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
          ],
        ),
        // ! Dokumen Tambahan
        SizedBox(
          height: 48,
        ),
        Text(
          "Kronologi Tambahan",
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
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FormFilePicker(
                    label: "BUKU KIR (KHUSUS MOBIL NIAGA)",
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
                    label: "COPY KTP PELAPOR",
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
                    label: "SURAT KUASA DARI DEBITUR KE PELAPOR",
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
                    label: "SURAT KETERANGAN HUBUNGAN PELAPOR DENGAN DEBITUR",
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
                    label: "SURAT KETERANGAN DEALER MENGENAI BPKB",
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
          ],
        ),
      ],
    );
  }
}
