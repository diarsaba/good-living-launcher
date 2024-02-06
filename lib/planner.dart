import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_living_launcher/models/activity.dart';
//import 'package:flutter_remix/flutter_remix.dart';

import 'bloc/blocs.dart';
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
    return Center(
      child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
        builder: (_, state) {
          // if(state is ActivitiesSetState){

          // }else if(state is ActivitiesInitialState){

          // }
          return state.activities.all.isEmpty
              ? const Center(
                  child: Icon(Icons.emoji_people_outlined,  size: 50,),
                )
              : Column(
                  children: [
                    ...state.activities.viewtodo.map((prof) {
                      if (prof is ActivityAlarm) {
                        return ListTile(
                          title: Text("-- ${prof.name}"),
                          subtitle: Text(prof.iconname),
                        );
                      } else {
                        prof = prof as ActivityPie;
                        return ListTile(
                          title: Text("-- ${prof.name}"),
                          subtitle:  Text("${prof.color} ${prof.endminutes}"),
                        );
                      }
                    }).toList(),
                    ...state.activities.viewmade.map((prof) {
                      if (prof is ActivityAlarm) {
                        return ListTile(
                          title: Text(prof.name),
                          subtitle: Text(prof.iconname),
                        );
                      } else {
                        prof = prof as ActivityPie;
                        return ListTile(
                          title: Text(prof.name),
                          subtitle:  Text("${prof.color} ${prof.endminutes}"),
                        );
                      }
                    }).toList()
                  ],
                );
        },
      ),
    );
  }
}
