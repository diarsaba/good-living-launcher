import 'package:flutter/material.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Days> selection = <Days>{};
  final modalcubit = getIt<ModalCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        const Text("Repetir los días"),
        const SizedBox(
          height: 5,
        ),
        SegmentedButton<Days>(
          emptySelectionAllowed: true,
          segments: const <ButtonSegment<Days>>[
            ButtonSegment<Days>(value: Days.l, label: Text('L')),
            ButtonSegment<Days>(value: Days.m, label: Text('M')),
            ButtonSegment<Days>(value: Days.x, label: Text('X')),
            ButtonSegment<Days>(
              value: Days.j,
              label: Text('J'),
            ),
            ButtonSegment<Days>(value: Days.v, label: Text('V')),
            ButtonSegment<Days>(value: Days.s, label: Text('S')),
            ButtonSegment<Days>(value: Days.d, label: Text('D')),
          ],
          selected: selection,
          onSelectionChanged: (Set<Days> newSelection) {
            setState(() {
              selection = newSelection;
              modalcubit.setChoiseDays(selection);
            });
          },
          multiSelectionEnabled: true,
        ),
      ],
    );
  }
}
