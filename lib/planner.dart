import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:good_living_launcher/iconshandler.dart';
import 'package:good_living_launcher/models/activity.dart';
//import 'package:flutter_remix/flutter_remix.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';
// import 'package:goodlivelauncher/iconshandler.dart';
// import 'package:device_apps/device_apps.dart';

enum Intervals { alarm, interval }

class Planner extends StatefulWidget {
  const Planner({super.key});
  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
    const String openbrake = "[";
    const String closebrake = "]";

    IconsHandler iconhandler = IconsHandler();

    return Center(
      child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
        builder: (_, state) {
          // if(state is ActivitiesSetState){

          // }else if(state is ActivitiesInitialState){

          // }
          return state.activities.all.isEmpty
              ? const Center(
                  child: Icon(
                    Icons.emoji_people_outlined,
                    size: 50,
                  ),
                )
              : ListView.builder(
                  itemCount: state.activities.view.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final activity = state.activities.view[index];

                    if (activity is ActivityAlarm) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.5),
                        ),
                        color: const Color.fromARGB(11, 0, 0, 0),
                        elevation: 0,
                        child: Column(children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                iconhandler.mapicon[activity.iconname]?.icon,
                                color: Colors.black,
                              ),
                              Text("${activity.name}"),
                              
                              Text(
                                "${activity.days.toString().replaceAll(',', '').replaceFirst(openbrake, '').replaceFirst(closebrake, '')} · ${activity.start.hour}:${activity.start.minute}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.note_outlined),
                              label: Text("notas")),
                          //Text(widget.activities.list[index].apps.toString()),
                        ]),
                      );
                    }

                    if (activity is ActivityPie) {
                      return Card(
                        child: Column(children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${activity.name}"),
                              Text(
                                "${activity.days.toString().replaceAll(',', '').replaceFirst(openbrake, '').replaceFirst(closebrake, '')} · ${activity.start.hour}:${activity.start.minute}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.note_outlined),
                              label: Text("notas")),
                          //Text(widget.activities.list[index].apps.toString()),

                          if (activity.apps.isNotEmpty)
                            SizedBox(
                              height: 50,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [...showapps(activity.apps)],
                              ),
                            ),
                          Container(
                            color: activity.color,
                            height: 3,
                            width: double.infinity,
                          ),
                        ]),
                      );
                    }
                  },
                );
        },
      ),
    );
  }

  List<Widget> showapps(List<String> apps) {
    final modalcubit = getIt<ModalCubit>();
    List<Widget> appsl = [];

    for (var i = 0; i < (modalcubit.state.modal.apps?.length ?? 0); i++) {
      if (apps.contains(modalcubit.state.modal.apps![i].packageName)) {
        final application =
            modalcubit.state.modal.apps![i] as ApplicationWithIcon;
        appsl.add(InkWell(
          onTap: () {
            DeviceApps.openApp(application.packageName);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Image.memory(application.icon),
          ),
        ));
      }
    }
    return appsl;
    //
  }
}
