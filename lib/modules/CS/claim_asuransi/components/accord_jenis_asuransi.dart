import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'dropdown_pencarian.dart';
import 'datatable/datatable_pencarian.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/form/form_data_nasabah.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/datatable/datatable_jenis_asuransi.dart';

class AccordionJenisAsuransi extends StatefulWidget {
  const AccordionJenisAsuransi({Key? key}) : super(key: key);
  @override
  State<AccordionJenisAsuransi> createState() => _AccordionJenisAsuransiState();
}

class _AccordionJenisAsuransiState extends State<AccordionJenisAsuransi> {
  // Show or hide the content
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: DataTableJenisAsuransi(),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
