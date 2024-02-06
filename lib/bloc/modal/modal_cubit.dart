import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:good_living_launcher/bloc/blocs.dart';
import 'package:good_living_launcher/bloc/service_locator.dart';

import '../../models/modal.dart';

part 'modal_state.dart';

enum TimeType { alarm, interval }

enum Days { l, m, x, j, v, s, d }

class ModalCubit extends Cubit<ModalState> {
  ModalCubit()
      : super(ModalInitialState(Modal(
          type: TimeType.alarm,
          days: <Days>{},
        )));

  void setName(String name) {
    emit(ModalUpdateState(state.modal.copyWith(name: name)));
  }

  void setNote(String note) {
    emit(ModalUpdateState(state.modal.copyWith(note: note)));
  }

  void setInterval(TimeOfDay start, TimeOfDay end, int minutes) {
    emit(ModalUpdateState(
        state.modal.copyWith(start: start, end: end, minutes: minutes)));
  }

  void setAlarm(TimeOfDay time) {
    emit(ModalUpdateState(state.modal.copyWith(time: time)));
  }

  void setChoiseTime(TimeType type) {
    emit(ModalUpdateState(state.modal.copyWith(type: type)));
  }

  void setChoiseDays(Set<Days> days) {
    emit(ModalUpdateState(state.modal.copyWith(days: days)));
  }

  void setIcon(String iconname) {
    emit(ModalUpdateState(state.modal.copyWith(iconname: iconname)));
  }

  void setApplications(List<Application> apps) {
    emit(ModalUpdateState(state.modal.copyWith(apps: apps)));
  }

  void setAplication(Application app) {
    if (!state.modal.selectedapps!.contains(app)) {
      final List<Application> newapps = [app, ...state.modal.selectedapps!];
      emit(ModalUpdateState(state.modal.copyWith(selectedapps: newapps)));
    }
  }

  void setColor(Color color) {
    emit(ModalUpdateState(state.modal.copyWith(color: color)));
  }

  void setRemoveAplication(int index) {
    List<Application> newapps = state.modal.apps?.where((app) {
          return app.packageName != app.packageName;
        }).toList() ??
        [];

    emit(ModalUpdateState(state.modal.copyWith(selectedapps: newapps)));
  }

  void setCalendarDateCode(String datecode, String weekday) {
    emit(ModalUpdateState(
        state.modal.copyWith(datecode: datecode, weekday: weekday)));

    getIt<ActivitiesCubit>().showCalendarDateCode(datecode, weekday);
  }

  void setinitial() {
    emit(ModalInitialState(Modal(type: TimeType.alarm, days: <Days>{}, datecode: state.modal.datecode, weekday: state.modal.weekday)));
  }
}
