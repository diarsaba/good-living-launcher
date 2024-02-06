import 'package:flutter/material.dart';
import 'package:good_living_launcher/iconshandler.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';

class DropdownMenuIcons extends StatefulWidget {
  const DropdownMenuIcons({super.key});

  @override
  State<DropdownMenuIcons> createState() => _DropdownMenuIconsState();
}

 class _DropdownMenuIconsState extends State<DropdownMenuIcons> {
  IconsHandler iconhandler = IconsHandler();
  late String dropdownValue = iconhandler.mapicon.entries.first.key;

  final modalcubit =  getIt<ModalCubit>();

  @override
  void initState() {
    super.initState();
    modalcubit.setIcon(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Representacion"),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            underline: null,
            menuMaxHeight: 300,
            value: dropdownValue,
            items: iconhandler.mapicon.keys.map(
              (item) {
                return DropdownMenuItem(
                  value: iconhandler.mapicon[item]?.name,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(iconhandler.mapicon[item]?.icon),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(iconhandler.mapicon[item]!.name)
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
                getIt<ModalCubit>().setIcon(value);
              });
            },
          ),
        ),
      ],
    );
  }
}
