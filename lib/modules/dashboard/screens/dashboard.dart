import 'package:flutter/material.dart';
import 'package:flutter_ori/bloc/sidebar_menu.dart';
import 'package:flutter_ori/modules/claim_asuransi/component/accord_data_nasabah.dart';
import 'package:flutter_ori/modules/claim_asuransi/component/accord_dokumen_klaim.dart';
import 'package:flutter_ori/modules/claim_asuransi/component/accord_jenis_asuransi.dart';
import 'package:flutter_ori/modules/claim_asuransi/component/accord_pencarian.dart';
import 'package:flutter_ori/modules/claim_asuransi/component/accord_histori_klaim.dart';
import 'package:flutter_ori/modules/claim_asuransi/component/accord_pengajuan_klaim.dart';
import 'package:flutter_ori/modules/dashboard/content/content.dart';
import 'package:flutter_ori/widgets/accordion.dart';
import 'package:flutter_ori/widgets/appbar/app_bar2.dart';
import 'package:flutter_ori/widgets/sidebar/side_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    SidebarMenuCubit myMenu = BlocProvider.of(context);
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 1,
            child: SideBar(route: 'dashboard'),
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
                      children: const [DashboardContent()],
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
