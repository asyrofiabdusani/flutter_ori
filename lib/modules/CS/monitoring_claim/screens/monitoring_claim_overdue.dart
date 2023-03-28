import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_data_nasabah.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_dokumen_klaim.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_histori_klaim.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_jenis_asuransi.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_pengajuan_klaim.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/accord/accord_tracking_progress.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/monitoring_claim_content.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/widgets/appbar/app_bar2.dart';
import 'package:flutter_ori/widgets/dialog/dialog_drop.dart';
import 'package:flutter_ori/widgets/dialog/dialog_regular.dart';
import 'package:flutter_ori/widgets/dialog/dialog_text_area.dart';
import 'package:flutter_ori/widgets/sidebar/side_bar.dart';
import 'package:flutter_ori/widgets/accordion.dart';
import 'package:flutter_ori/widgets/timeline/timeline.dart';

class MonitoringClaimOverdue extends StatelessWidget {
  const MonitoringClaimOverdue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 1,
            child: SideBar(route: 'monitoring_claim'),
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
                          SizedBox(
                            height: 30,
                          ),
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
                          Accordion(
                              title: "Tracking Progress",
                              content: AccordionTrackingProgress()),
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
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return DialogDrop(
                                              dialogWidth: 596,
                                              dialogHeight: 514,
                                              dialogImg:
                                                  'assets/images/5527-alert-notification-character 1.png',
                                              dialogImgWidth: 250,
                                              dialogImgHeight: 250,
                                              dialogTopText:
                                                  'Apakah anda yakin ingin batalkan pengajuan?',
                                              dialogBottomText:
                                                  'Pilih Alasan pembatalan',
                                              primaryBtText: 'Ya, Ubah Data',
                                              secondaryBtText: 'Kembali',
                                              primaryBtIsShow: true,
                                              secondaryBtIsShow: true,
                                              primaryCallback: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return DialogRegular(
                                                        dialogWidth: 596,
                                                        dialogHeight: 496,
                                                        dialogImg:
                                                            'assets/images/59945-success-confetti 1.png',
                                                        dialogImgWidth: 250,
                                                        dialogImgHeight: 250,
                                                        dialogTopText:
                                                            'Berhasil!!',
                                                        dialogBottomText:
                                                            'Data berhasil dikirim',
                                                        primaryBtText: '',
                                                        secondaryBtText:
                                                            'Kembali',
                                                        primaryBtIsShow: false,
                                                        secondaryBtIsShow: true,
                                                        primaryCallback: () {},
                                                        secondaryCallback: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                  },
                                                );
                                              },
                                              secondaryCallback: () {
                                                Navigator.of(context).pop();
                                              });
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  AdButtonPrimary(
                                    text: ('Input Hasil Follow Up'),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return DialogTextArea(
                                              dialogWidth: 560,
                                              dialogHeight: 412,
                                              dialogTitle: "",
                                              dialogLabel:
                                                  "Input hasil Follow Up",
                                              dialogTextHint:
                                                  "Isi Hasil Follow up",
                                              dialogMaxLines: 15,
                                              primaryBtText: "Submit Hasil",
                                              secondaryBtText: "Batal",
                                              primaryBtIsShow: true,
                                              secondaryBtIsShow: true,
                                              primaryCallback: () {},
                                              secondaryCallback: () {});
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
