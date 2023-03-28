import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_data_nasabah.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_dokumen_klaim.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_histori_klaim.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_jenis_asuransi.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/components/accord_pengajuan_klaim.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/accord/accord_tracking_progress.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/monitoring_claim_content.dart';
import 'package:flutter_ori/widgets/appbar/app_bar2.dart';
import 'package:flutter_ori/widgets/sidebar/side_bar.dart';
import 'package:flutter_ori/widgets/accordion.dart';
import 'package:flutter_ori/widgets/timeline/timeline.dart';

class MonitoringClaimBanding extends StatelessWidget {
  const MonitoringClaimBanding({super.key});

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
                    child: Column(
                      children: const [
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
