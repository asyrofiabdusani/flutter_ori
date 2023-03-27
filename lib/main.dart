import 'package:flutter/material.dart';
import 'package:flutter_ori/bloc/to_do_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ori/modules/dashboard/screens/dashboard.dart';
import 'package:flutter_ori/modules/claim_asuransi/screens/claim_asuransi.dart';
import 'package:flutter_ori/modules/monitoring_claim/screens/monitoring_claim.dart';

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
        },
      ),
    );
  }
}
