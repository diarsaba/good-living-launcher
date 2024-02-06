import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_living_launcher/bloc/calendar/calendar_cubit.dart';
//import 'package:flutter_remix/flutter_remix.dart';
//import 'package:goodlivelauncher/activity.dart.txt';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';
import 'models/calendar.dart';

class HorizontalCalendar extends StatefulWidget {
  //final Activities activities;
  const HorizontalCalendar({super.key});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  //--------------------------------

  final itemController = ItemScrollController();
  final modalcubit = getIt<ModalCubit>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToIndex(30));
  }

  void scrollToIndex(int index) => itemController.jumpTo(index: index);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (_, state) {
          return ScrollablePositionedList.builder(
              itemScrollController: itemController,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: state.calendar.days.length,
              itemBuilder: (BuildContext context, int index) {
                return dayWidget(state.calendar.days[index]);
              });
        },
      ),
    );
  }

  dayWidget(Day day) {
    return InkWell(
      onTap: () {
        modalcubit.setCalendarDateCode(day.datecode, day.weekday);
      },
      child: Card(
        color: day.today ? Colors.black12 : Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 1,
        child: Column(
          children: [
            Container(
              width: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: Colors.black26,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  day.weekday,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              day.month,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            Text(
              day.day,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
