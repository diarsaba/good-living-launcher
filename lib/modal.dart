
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_living_launcher/bloc/service_locator.dart';
import 'package:good_living_launcher/colorpicker.dart';
import 'package:good_living_launcher/dropdown.dart';

import 'package:good_living_launcher/dropdownicon.dart';
import 'package:good_living_launcher/iconshandler.dart';
import 'package:good_living_launcher/interval.dart';
import 'package:good_living_launcher/segment.dart';

import 'bloc/blocs.dart';

class ModalInputs extends StatefulWidget {
  const ModalInputs({super.key});

  @override
  State<ModalInputs> createState() => _ModalInputsState();
}

class _ModalInputsState extends State<ModalInputs> {
  IconsHandler iconhandler = IconsHandler();
  late String iconname_ = iconhandler.mapicon.entries.first.key;

  final modalcubit = getIt<ModalCubit>();

  // TextEditingController nameTextController = TextEditingController();
  // TextEditingController descriptionTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModalCubit, ModalState>(
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (s) {
            modalcubit.setinitial();
          },
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 0.0, // has the effect of extending the shadow
                  )
                ],
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: const Text(
                          "Actividad ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 5, right: 5),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 5, right: 5),
                              child: TextButton(
                                onPressed: cansave(state)
                                    ? () {
                                         getIt<ActivitiesCubit>().addActivity(state.modal);
                                        

                                        
                                        modalcubit.setinitial();
                                        Navigator.pop(context);
                                      }
                                    : null,
                                child: Text(
                                  "Guardar",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: cansave(state)
                                        ? Colors.black54
                                        : Colors.black12,
                                  ),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0xfff8f8f8),
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                modalcubit.setName(text);
                              });
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Nombre"),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: (text) {
                              setState(() {
                                modalcubit.setNote(text);
                              });
                            },
                            minLines:
                                2, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Descripción"),
                          ),

                          const SizedBox(height: 15),
                          const SingleChoice(),

                          const ColorPickerPage(),

                          const SizedBox(height: 5),
                          if (state.modal.type == TimeType.interval)
                            const DropdownMenuExample(),
                          
                          if (state.modal.type == TimeType.alarm)
                            const DropdownMenuIcons(),
                          const MultipleChoice()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  bool cansave(ModalState state) {
    return ((state.modal.type == TimeType.alarm && state.modal.time != null) ||
        (state.modal.type == TimeType.interval &&
                state.modal.start != null &&
                state.modal.end != null) &&
            modalcubit.state.modal.name != null);
  }
}
