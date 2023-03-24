import 'package:flutter/material.dart';

import 'package:flutter_ori/modules/dashboard/screens/dashboard.dart';
import 'package:flutter_ori/modules/claim_asuransi/screens/claim_asuransi.dart';
import 'package:flutter_ori/modules/monitoring_claim/screens/monitoring_claim.dart';


void main() {
  runApp(MyApp());
}

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
    return MaterialApp(
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
      },
    );
  }
}
