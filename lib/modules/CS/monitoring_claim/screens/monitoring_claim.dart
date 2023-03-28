import 'package:flutter/material.dart';
import 'package:flutter_ori/modules/CS/monitoring_claim/components/monitoring_claim_content.dart';
import 'package:flutter_ori/widgets/appbar/app_bar2.dart';
import 'package:flutter_ori/widgets/sidebar/side_bar.dart';

class MonitoringClaim extends StatelessWidget {
  const MonitoringClaim({super.key});

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
                      children: const [MonitoringClaimContent()],
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
