import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';
//import 'package:goodlivelauncher/activity.dart.txt';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final modalcubit = getIt<ModalCubit>();

  late Application dropdownValue = getIt<ModalCubit>().state.modal.apps!.first;
  //modalcubit.state.modal.apps!.isNotEmpty

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModalCubit, ModalState>(
      builder: (_, __) {
        return Column(
          children: [
            if (modalcubit.state.modal.selectedapps!.isEmpty) const Icon(FlutterRemix.eye_close_line),
            if (modalcubit.state.modal.type == TimeType.interval &&
                modalcubit.state.modal.selectedapps!.isNotEmpty)
              SizedBox(
                height: 45,
                child: ListView.builder(
                    cacheExtent: 20,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: modalcubit.state.modal.selectedapps!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final application =
                          modalcubit.state.modal.selectedapps![index] as ApplicationWithIcon;
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Color.fromARGB(255, 228, 228, 228),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                //Text(selected[index]),
                                Image.memory(application.icon),
                                const SizedBox(
                                  width: 3,
                                ),
                                IconButton(
                                    onPressed: () {
                                      modalcubit.setRemoveAplication(index);
                                    },
                                    icon: const Icon(
                                        FlutterRemix.close_circle_line))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    underline: null,
                    menuMaxHeight: 300,
                    value: dropdownValue,
                    items: modalcubit.state.modal.apps!.map(
                      (item) {
                        final application = item as ApplicationWithIcon;
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.memory(application.icon),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(application.appName)
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                        modalcubit.setAplication(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
