import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/dashboard/dashboard.dart';
import 'package:flutter_ori/modules/screens/claim_asuransi/claim_asuransi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        },
      ),
    );
  }
}
