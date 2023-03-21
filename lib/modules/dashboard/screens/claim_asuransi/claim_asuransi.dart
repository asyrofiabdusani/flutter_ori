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
import 'package:flutter_ori/widgets/dialog/dialog_regular.dart';
import 'package:flutter_ori/widgets/dialog/dialog_drop.dart';

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
                const AppBar2(),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 55,
                  child: SingleChildScrollView(
                    child: Column(
                      /* children: [
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


                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return DialogDrop(
                                    dialogWidth: 596,
                                    dialogHeight: 496,
                                    dialogImg:
                                        'images/60875-confuse-person-1.png',
                                    dialogImgWidth: 250,
                                    dialogImgHeight: 250,
                                    dialogTopText:
                                        'Apakah anda yakin ingin batalkan pengajuan?',
                                    dialogBottomText: 'Pilih Alasan pembatalan',
                                    primaryBtText: 'Ya, Kirim SRH',
                                    secondaryBtText: 'Kembali',
                                    primaryBtIsShow: true,
                                    secondaryBtIsShow: true,
                                    primaryCallback: () {
                                      print('send');
                                    },
                                    secondaryCallback: () {
                                      print('back');
                                    },
                                  );
                                });
                          },
                          child: Center(
                            child: Text('Open Dialog'),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
