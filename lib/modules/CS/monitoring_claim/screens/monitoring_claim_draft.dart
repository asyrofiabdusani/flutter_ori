import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_data_nasabah.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_dokumen_klaim.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_jenis_asuransi.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_pencarian.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_histori_klaim.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_pengajuan_klaim.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/widgets/accordion.dart';
import 'package:flutter_ori/widgets/appbar/app_bar2.dart';
import 'package:flutter_ori/widgets/sidebar/side_bar.dart';

class MonitoringClaimDraft extends StatelessWidget {
  const MonitoringClaimDraft({super.key});

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
              child: SideBar(
                route: '',
              ),
            ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Accordion(
                              title: "Pencarian",
                              content: AccordionPencarian()),
                          const Accordion(
                              title: "Data Nasabah",
                              content: AccordionDataNasabah()),
                          const Accordion(
                              title: "Jenis Asuransi",
                              content: AccordionJenisAsuransi()),
                          const Accordion(
                              title: "Histori Klaim",
                              content: AccordionHistoriKlaim()),
                          const Accordion(
                              title: "Pengajuan Klaim",
                              content: AccordionPengajuanKlaim()),
                          const Accordion(
                              title: "Dokumen Klaim",
                              content: AccordionDokumenKlaim()),
                          Container(
                            height: 104,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(adrSize.radiusSmall),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  AdButtonText(
                                    text: 'Batalkan Pengajuan',
                                    danger: true,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: AdButtonSecondary(
                                      text: 'Perbarui Draft',
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  AdButtonPrimary(
                                    text: ('Kirim Ke SRH'),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        //children: [DashboardContent()],

                        /* children: [
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
                        ], */
                      ),
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
