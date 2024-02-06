import 'package:flutter/material.dart';

class Activities {
  final List<Activity> viewtodo;
  final List<Activity> viewmade;
  final List<Activity> view;

  final List<Activity> all;

  // late List<Color> colorList = [const Color.fromARGB(0, 0, 0, 0)];
  // late Map<String, double> dataMap = {'a': 1};

  final List<Color> colorlist;
  final Map<String, double> datamap;

  Activities(
      {required this.viewtodo,
      required this.viewmade,
      required this.all,
      required this.view,
      required this.colorlist,
      required this.datamap});

  Activities copyWith({
    List<Activity>? viewtodo,
    List<Activity>? viewmade,
    List<Activity>? all,
    List<Activity>? view,
    List<Color>? colorlist,
    Map<String, double>? datamap,
  }) =>
      Activities(
        viewtodo: viewtodo ?? this.viewtodo,
        viewmade: viewmade ?? this.viewmade,
        all: all ?? this.all,
        view: view ?? this.view,
        colorlist: colorlist ?? this.colorlist,
        datamap: datamap ?? this.datamap,
      );
}

class Activity {
  String name;

  TimeOfDay start;
  int startminutes;

  Color color;
  String datecode;
  List<String> days;

  List<String> notesuuids;
  List<String> notes;

  Activity({
    required this.name,
    required this.datecode,
    required this.start,
    required this.notesuuids,
    required this.notes,
    required this.color,
    required this.days,
    required this.startminutes,
  });
}

class ActivityAlarm extends Activity {
  String iconname;

  ActivityAlarm(
      {required super.name,
      required this.iconname,
      required super.datecode,
      required super.days,
      required super.color,
      required super.notesuuids,
      required super.notes,
      required super.start,
      required super.startminutes});

  ActivityAlarm copyWith({
    String? name,
    String? type,
    TimeOfDay? start,
    List<String>? notesuuids,
    List<String>? notes,
    Color? color,
    List<String>? days,
    String? datecode,
    String? iconname,
    int? startminutes,
  }) =>
      ActivityAlarm(
          name: name ?? this.name,
          start: start ?? this.start,
          notesuuids: notesuuids ?? this.notesuuids,
          notes: notes ?? this.notes,
          color: color ?? this.color,
          days: days ?? this.days,
          datecode: datecode ?? this.datecode,
          iconname: iconname ?? this.iconname,
          startminutes: startminutes ?? this.startminutes);
}

class ActivityPie extends Activity {
  TimeOfDay end;
  int endminutes;
  List<String> apps;

  ActivityPie({
    required super.name,
    required this.end,
    required this.apps,
    required super.datecode,
    required super.days,
    required super.color,
    required super.notesuuids,
    required super.notes,
    required super.start,
    required this.endminutes,
    required super.startminutes,
  });

  ActivityPie copyWith({
    String? name,
    String? type,
    TimeOfDay? start,
    List<String>? notesuuids,
    List<String>? notes,
    Color? color,
    List<String>? days,
    String? datecode,
    TimeOfDay? end,
    List<String>? apps,
    int? endminutes,
    int? startminutes,
  }) =>
      ActivityPie(
        startminutes: startminutes ?? this.startminutes,
        endminutes: endminutes ?? this.endminutes,
        name: name ?? this.name,
        start: start ?? this.start,
        notesuuids: notesuuids ?? this.notesuuids,
        notes: notes ?? this.notes,
        color: color ?? this.color,
        days: days ?? this.days,
        datecode: datecode ?? this.datecode,
        end: end ?? this.end,
        apps: apps ?? this.apps,
      );
}
