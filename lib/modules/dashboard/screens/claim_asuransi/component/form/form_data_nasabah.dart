import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';

class FormDataNasabah extends StatefulWidget {
  const FormDataNasabah({super.key});

  @override
  State<FormDataNasabah> createState() => _FormDataNasabahState();
}

class _FormDataNasabahState extends State<FormDataNasabah> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "No. Memo",
                      labelText: "No. Memo",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "No. Kontrak",
                      labelText: "No. Kontrak",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "No. Nasabah",
                      labelText: "No. Nasabah",
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "Status. Kontrak",
                      labelText: "Status. Kontrak",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: "Alamat",
                      labelText: "Alamat",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "No. Polis",
                      labelText: "No. Polis",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "Jenis Kendaraan",
                      labelText: "Jenis Kendaraan",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "No. Mesin",
                      labelText: "No. Mesin",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AdTextFormField(
                    decoration: InputDecoration(
                      hintText: "No. Rangka",
                      labelText: "No. Rangka",
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
