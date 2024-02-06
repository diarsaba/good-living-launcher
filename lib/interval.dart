import 'package:flutter/material.dart';
import 'package:good_living_launcher/bloc/service_locator.dart';

import 'bloc/blocs.dart';

class SingleChoice extends StatefulWidget {
  //final Function(TimeOfDay, TimeOfDay, int) interval;

  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  TimeType selectedInterval = TimeType.alarm;

  TextEditingController timeinput = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController starttimeinput = TextEditingController();
  TimeOfDay startselectedTime = TimeOfDay.now();

  TextEditingController endtimeinput = TextEditingController();
  TimeOfDay endselectedTime = TimeOfDay.now();

  late int minutes = 0;

  final modalcubit = getIt<ModalCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SegmentedButton<TimeType>(
        segments: const <ButtonSegment<TimeType>>[
          ButtonSegment<TimeType>(
              value: TimeType.alarm,
              label: Text('Alarma'),
              icon: Icon(Icons.alarm_outlined)),
          ButtonSegment<TimeType>(
              value: TimeType.interval,
              label: Text('Intervalo'),
              icon: Icon(Icons.calendar_view_week)),
        ],
        selected: <TimeType>{selectedInterval},
        onSelectionChanged: (Set<TimeType> newSelection) {
          setState(() {
            selectedInterval = newSelection.first;
            modalcubit.setChoiseTime(selectedInterval);
          });
        },
      ),
      const SizedBox(height: 10),
      if (selectedInterval == TimeType.alarm)
        TextField(
          controller: timeinput, //editing controller of this TextField
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Hora" //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
                initialTime: selectedTime,
                context: context,
                initialEntryMode: TimePickerEntryMode.dial);

            if (pickedTime != null) {
              timeinput.text =
                  '${pickedTime.hour}:${pickedTime.minute} ${pickedTime.hourOfPeriod}';
              modalcubit.setAlarm(pickedTime);
            } else {
              print("Time is not selected");
            }
          },
        ),
      if (selectedInterval == TimeType.interval)
        Column(
          children: [
            TextField(
              controller: starttimeinput, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Inicio" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: startselectedTime,
                    context: context,
                    initialEntryMode: TimePickerEntryMode.dial);

                if (pickedTime != null) {
                  setState(() {
                    startselectedTime = pickedTime;
                    starttimeinput.text =
                        '${pickedTime.hour}:${pickedTime.minute}';
                    //TODO:regresar valor
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: endtimeinput, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Final" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: selectedTime,
                    context: context,
                    initialEntryMode: TimePickerEntryMode.dial);

                if (pickedTime != null) {
                  // timeinterval = 5;

                  setState(() {
                    endselectedTime = pickedTime;
                    if (endselectedTime.hour > startselectedTime.hour ||
                        endselectedTime.minute > startselectedTime.minute) {
                      endtimeinput.text =
                          '${pickedTime.hour}:${pickedTime.minute}';

                      if (endselectedTime.hour == startselectedTime.hour) {
                        minutes =
                            endselectedTime.minute - startselectedTime.minute;
                      } else if (endselectedTime.hour >
                          startselectedTime.hour) {
                        minutes = (endselectedTime.hour -
                                    startselectedTime.hour) *
                                60 +
                            (endselectedTime.minute - startselectedTime.minute);
                      } else {
                        minutes = ((24 - startselectedTime.hour) +
                                    endselectedTime.hour) *
                                60 +
                            endselectedTime.minute +
                            startselectedTime.minute;
                      }

                      modalcubit.setInterval(
                          startselectedTime, endselectedTime, minutes);
                    }
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            const SizedBox(height: 5),
            if (minutes != 0)
              Container(
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "intervalo de ${(minutes / 60).floor()}:${minutes % 60} horas",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        )
    ]);
  }
}
