import 'package:flutter/material.dart';

import 'package:flutter_ori/modules/dashboard/screens/dashboard.dart';
import 'package:flutter_ori/modules/claim_asuransi/screens/claim_asuransi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ori/modules/monitoring_claim/screens/monitoring_claim.dart';
import 'package:flutter_ori/modules/monitoring_claim/screens/monitoring_claim_banding.dart';
import 'package:flutter_ori/widgets/timeline/timeline.dart';
import 'bloc/sidebar_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SidebarMenuCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/dashboard',
        routes: {
          '/dashboard': (context) => const Dashboard(),
          '/claim_asuransi': (context) => const ClaimAsuransi(),
          '/monitoring_claim': (context) => const MonitoringClaim(),
          '/monitoring_claim/banding': (context) =>
              const MonitoringClaimBanding(),
          '/testing_widget': (context) => const AdTimeLine(),
        },
      ),
    );
  }
}
