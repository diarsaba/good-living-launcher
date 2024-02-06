import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
//import 'package:goodlivelauncher/activity.dart.txt';
import 'package:good_living_launcher/calendar.dart';
import 'package:good_living_launcher/planner.dart';
import 'package:good_living_launcher/solar.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';

class GoodLiveLauncherPage extends StatefulWidget {
  const GoodLiveLauncherPage({super.key});
  @override
  State<GoodLiveLauncherPage> createState() => _GoodLiveLauncherPageState();
}

class _GoodLiveLauncherPageState extends State<GoodLiveLauncherPage> {
  @override
  void initState() {
    super.initState();
    // activities = Activities(
    //     name: "diarsaba",
    //     uuid: "000",
    //     password: "",
    //     );
    getApplications();
  }

  void getApplications() async {
    final apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    getIt<ModalCubit>().setApplications(apps);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HorizontalCalendar(),
          Solar(),
          Planner()
        ],
      ),
    );
  }
}
