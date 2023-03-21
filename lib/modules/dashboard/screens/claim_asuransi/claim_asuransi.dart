import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/accord_data_nasabah.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/accord_dokumen_klaim.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/accord_jenis_asuransi.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/accord_pencarian.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/accord_histori_klaim.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/accord_pengajuan_klaim.dart';
import 'package:flutter_ori/modules/dashboard/screens/claim_asuransi/component/form/form_data_nasabah.dart';
import 'package:flutter_ori/widgets/accordion.dart';
import 'package:flutter_ori/widgets/appbar/app_bar2.dart';
import 'package:flutter_ori/widgets/sidebar/side_bar.dart';
import 'package:flutter_ori/widgets/appbar/app_bar.dart';
import '../content/content.dart';

class ClaimAsuransi extends StatelessWidget {
  const ClaimAsuransi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: SideBar(),
            ),

            //Container(
            //   color: Color.fromRGBO(255, 235, 116, 1.0),
            //   child: Column(
            //     children: [
            //       Stack(
            //         alignment: Alignment.center,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(top: 32),
            //             child: Image.asset('logo-ADMF.png'),
            //           )
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 56),
            //         child: SizedBox(
            //           height: 50,
            //           width: 250,
            //           child: ContactButton(
            //               buttonText: 'Dashboard',
            //               icon: Icon(Icons.house, color: Colors.white),
            //               onPressed: () => print('hellow World')),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar2(),
                  Container(
                    height: MediaQuery.of(context).size.height - 55,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Accordion(
                              title: "Pencarian",
                              content: AccordionPencarian()),
                          Accordion(
                              title: "Data Nasabah",
                              content: AccordionDataNasabah()),
                          Accordion(
                              title: "Jenis Asuransi",
                              content: AccordionJenisAsuransi()),
                          Accordion(
                              title: "Histori Klaim",
                              content: AccordionHistoriKlaim()),
                          Accordion(
                              title: "Pengajuan Klaim",
                              content: AccordionPengajuanKlaim()),
                          Accordion(
                              title: "Dokumen Klaim",
                              content: AccordionDokumenKlaim()),
                        ],
                        //children: [DashboardContent()],

                      ),
                    ),
                  )
                ],
              ),),
        ],
      ),
    );
  }
}
