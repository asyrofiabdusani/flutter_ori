import 'package:flutter/material.dart';
import 'package:flutter_ori/bloc/to_do_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ori/modules/CS/dashboard/screens/dashboard.dart';
import 'package:flutter_ori/modules/CS/claim_asuransi/screens/claim_asuransi.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/form/form_bukti_kirim_berkas.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_banding.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_bukti.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_draft.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_exgratia.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_hasil.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_kekurangan.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_koreksi.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/screens/monitoring_claim_overdue.dart';
import 'package:flutter_ori/widgets/modal/modal.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map routes = {
    '/': (context) => const Dashboard(),
    '/dashboard': (context) => const Dashboard(),
    '/claim_asuransi': (context) => const ClaimAsuransi(),
    '/monitoring_claim': (context) => const MonitoringClaim(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoMenuCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Dashboard(),
          '/dashboard': (context) => const Dashboard(),
          '/claim_asuransi': (context) => const ClaimAsuransi(),
          '/monitoring_claim': (context) => const MonitoringClaim(),
          '/monitoring_claim/banding': (context) =>
              const MonitoringClaimBanding(),
          '/monitoring_claim/draft': (context) => const MonitoringClaimDraft(),
          '/monitoring_claim/koreksi': (context) =>
              const MonitoringClaimKoreksi(),
          '/monitoring_claim/kekurangan': (context) =>
              const MonitoringClaimKekurangan(),
          '/monitoring_claim/hasil': (context) => const MonitoringClaimHasil(),
          '/monitoring_claim/bukti': (context) => const MonitoringClaimBukti(),
          '/monitoring_claim/overdue': (context) =>
              const MonitoringClaimOverdue(),
          '/monitoring_claim/exgratia': (context) =>
              const MonitoringClaimExGratia(),
          '/testing_widget': (context) => Modal(),
        },
      ),
    );
  }
}
