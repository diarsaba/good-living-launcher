import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import '../bloc/blocs.dart';

class Modal {

  final String? name;
  final String? note;

  final TimeType type;
  final Set<Days> days;

  final String? iconname;
  final Color? color;

  final TimeOfDay? start;

  final TimeOfDay? end;
  final int? minutes;

  final TimeOfDay? time;

  final List<Application>? apps;
  final List<Application>? selectedapps;

  final String? datecode;
  final String? weekday; 
  

  Modal({
     this.name,
     this.note,
    required this.type,
    required this.days,
    this.start,
    this.end,
    this.minutes,
    this.time,
    this.iconname,
    this.apps,
    this.selectedapps,
    this.color, 
    this.datecode,
    this.weekday
  });
  //required this.start, required this.end, required this.minutes, required this.time
  Modal copyWith({
    String? name, 
    String? note,
    TimeType? type,
    Set<Days>? days,
    TimeOfDay? start,
    TimeOfDay? end,
    TimeOfDay? time,
    int? minutes,
    String? iconname,
    List<Application>? apps,
    List<Application>? selectedapps,
    Color? color,
    String? datecode,
    String? weekday
  }) =>
      Modal(
        name: name ?? this.name,
        note: note ?? this.note,
        type: type ?? this.type,
        days: days ?? this.days,
        start: start ?? this.start,
        end: end ?? this.end,
        minutes: minutes ?? this.minutes,
        time: time ?? this.time,
        iconname: iconname ?? this.iconname,
        apps: apps ?? this.apps,
        selectedapps: selectedapps ?? this.selectedapps,
        color: color?? this.color,
        datecode: datecode ?? this.datecode,
        weekday: weekday ?? this.weekday
      );
}
