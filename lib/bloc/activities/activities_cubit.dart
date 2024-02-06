import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:good_living_launcher/models/activity.dart';
import 'package:good_living_launcher/models/modal.dart';


import '../blocs.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit()
      : super(ActivitiesInitialState(Activities(
            viewtodo: [],
            viewmade: [],
            all: [],
            view: [],
            colorlist: [const Color.fromARGB(0, 0, 0, 0)],
            datamap: {'a': 1})));

  void addActivity(Modal modal) {
    if (modal.type == TimeType.alarm) {
      final activity = ActivityAlarm(
          name: modal.name ?? "No name",
          iconname: modal.iconname ?? "no-icon",
          datecode: modal.datecode ?? "",
          days: modal.days.toList().map((e) => e.name.toUpperCase()).toList(),
          color: modal.color ?? Colors.black,
          notesuuids: [],
          notes: [],
          start: modal.time ?? TimeOfDay.now(),
          startminutes: modal.time!.hour * 60 + modal.time!.minute);

      emit(ActivitiesUpdateState(
          state.activities.copyWith(all: [...state.activities.all, activity])));
    } else {
      final activity = ActivityPie(
          name: modal.name ?? "No name",
          start: modal.start ?? TimeOfDay.now(),
          end: modal.end ?? TimeOfDay.now(),
          apps:
              modal.selectedapps?.toList().map((e) => e.packageName).toList() ??
                  [],
          datecode: modal.datecode ?? "",
          days: modal.days.toList().map((e) => e.name.toUpperCase()).toList(),
          color: modal.color ?? Colors.black,
          notesuuids: [],
          notes: [],
          startminutes: modal.start!.hour * 60 + modal.start!.minute,
          endminutes: modal.end!.hour * 60 + modal.end!.minute);

      emit(ActivitiesUpdateState(
          state.activities.copyWith(all: [...state.activities.all, activity])));
    }

    showCalendarDateCode(modal.datecode!, modal.weekday!);
  }

  // void sortViewtodo() {
  //   late List<int> temp = [];
  //   late List<int> orig = [];

  //   for (var i = 0; i < state.activities.view.length; i++) {
  //     final x = state.activities.view[i].startminutes;
  //     temp.add(x);
  //     orig.add(x);
  //   }

  //   temp.sort();

  //   List<Activity> tempactivity = [];
  //   for (var i = 0; i < temp.length; i++) {
  //     final index = orig.indexOf(temp[i]);
  //     tempactivity.add(state.activities.view[index]);
  //   }

  //   emit(ActivitiesUpdateState(state.activities.copyWith(view: tempactivity)));
  // }

  List<Activity> _sort(List<Activity> list){
    late List<int> temp = [];
    late List<int> orig = [];

    for (var i = 0; i < list.length; i++) {
      final x = list[i].startminutes;
      temp.add(x);
      orig.add(x);
    }

    temp.sort();

    List<Activity> tempactivity = [];
    for (var i = 0; i < temp.length; i++) {
      final index = orig.indexOf(temp[i]);
      tempactivity.add(list[index]);
    }

    return tempactivity;
  }

  void _datamap() {

    final view = _sort(state.activities.view);

    late List<double> partsize = [];
    late List<Color> colorList = [];
    late Map<String, double> dataMap = {};

    //late double tempstart =0;
    late int tempend = 0;
    //late double total = 0;

    for (var i = 0; i < view.length; i++) {
      final list = view[i];
      if (list is ActivityPie) {
        final timeinterval = list.endminutes - list.startminutes;
        if (list.startminutes > tempend) {
          //habra un espacio blanco
          final emptysize = (list.startminutes - tempend) / 1440;

          colorList.add(const Color.fromARGB(14, 0, 0, 0));
          partsize.add(emptysize);

          partsize.add(timeinterval / 1440);
          colorList.add(list.color);

          tempend = list.endminutes;
        } else if (list.startminutes == tempend) {
          // no habra espacio
          partsize.add(timeinterval / 1440);
          colorList.add(list.color);

          tempend = list.endminutes;
        } else if (list.startminutes < tempend) {
          // hay un solapamiento
          final solapsize = (tempend - list.startminutes) / 1440;
          //final reducesolap = solapsize / 2;

          final partsizelen = partsize.length;
          partsize[partsizelen - 1] = partsize[partsizelen - 1] - solapsize;

          partsize.add(solapsize);
          colorList.add(const Color.fromARGB(255, 0, 0, 0));

          partsize.add((timeinterval / 1440) - solapsize);
          colorList.add(list.color);

          tempend = list.endminutes;
        }
      }
    }

    if (tempend < 1440) {
      partsize.add(((1440 - tempend) / 1440));
      colorList.add(const Color.fromARGB(14, 0, 0, 0));
    }

    for (var i = 0; i < partsize.length; i++) {
      dataMap.addEntries(<String, double>{'a$i': partsize[i]}.entries);
    }

    if (partsize.isEmpty) {
      emit(ActivitiesUpdateState(state.activities.copyWith(
          datamap: {'a': 1}, colorlist: [const Color.fromARGB(0, 0, 0, 0)])));
    } else {
      emit(ActivitiesUpdateState(
          state.activities.copyWith(datamap: dataMap, colorlist: colorList)));
    }
  }

  void showCalendarDateCode(String datecode, String weekday) {
    final current = TimeOfDay.now();
    final minutes = current.hour * 60 + current.minute;

    List<Activity> view = state.activities.all.where((activity) {
      if (activity.days.isEmpty) {
        return activity.datecode == datecode;
      } else {
        return activity.days.contains(weekday);
      }
    }).toList();

    List<Activity> todo = view.where((activity) {
      if (activity is ActivityPie) {
        return activity.endminutes > minutes;
      } else {
        return activity.startminutes > minutes;
      }
    }).toList();

    List<Activity> made = view.where((activity) {
      if (activity is ActivityPie) {
        return activity.endminutes < minutes;
      } else {
        return activity.startminutes < minutes;
      }
    }).toList();

    emit(ActivitiesUpdateState(state.activities.copyWith(viewtodo: _sort(todo), viewmade: _sort(made), view: view)));

    _datamap();
  }
}

// todo; icono, 
