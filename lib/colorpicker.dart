import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'bloc/blocs.dart';
import 'bloc/service_locator.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({
    super.key,
  });
  //required this.themeMode
  //final ValueChanged<ThemeMode> themeMode;

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  final modalcubit = getIt<ModalCubit>();

  late Color screenPickerColor; // Color for picker shown in Card on the screen.
  late Color dialogPickerColor; // Color for picker in dialog using onChanged
  late Color dialogSelectColor; // Color for picker using color select dialog.
  late bool isDark;

  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  @override
  void initState() {
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
    dialogSelectColor = const Color(0xFFA239CA);
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Selecciona el color de la actividad'),
      subtitle: Text(
        '${ColorTools.materialNameAndCode(dialogSelectColor, colorSwatchNameMap: colorsNameMap)} '
        'aka ${ColorTools.nameThatColor(dialogSelectColor)}',
      ),
      trailing: ColorIndicator(
          width: 40,
          height: 40,
          borderRadius: 0,
          color: dialogSelectColor,
          elevation: 1,
          onSelectFocus: false,
          onSelect: () async {
            // Wait for the dialog to return color selection result.
            final Color newColor = await showColorPickerDialog(
              // The dialog needs a context, we pass it in.
              context,
              // We use the dialogSelectColor, as its starting color.
              dialogSelectColor,
              title: Text('', style: Theme.of(context).textTheme.titleLarge),
              width: 40,
              height: 40,
              spacing: 0,
              runSpacing: 0,
              borderRadius: 0,
              wheelDiameter: 165,
              enableOpacity: true,
              showColorCode: true,
              colorCodeHasColor: true,
              pickersEnabled: <ColorPickerType, bool>{
                ColorPickerType.wheel: true,
              },
              copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                copyButton: false,
                pasteButton: false,
                longPressMenu: false,
              ),
              actionButtons: const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                dialogActionButtons: false,
              ),
              transitionBuilder: (BuildContext context, Animation<double> a1,
                  Animation<double> a2, Widget widget) {
                final double curvedValue =
                    Curves.easeInOutBack.transform(a1.value) - 1.0;
                return Transform(
                  transform:
                      Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                  child: Opacity(
                    opacity: a1.value,
                    child: widget,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
              constraints: const BoxConstraints(
                  minHeight: 480, minWidth: 320, maxWidth: 320),
            );
            // We update the dialogSelectColor, to the returned result
            // color. If the dialog was dismissed it actually returns
            // the color we started with. The extra update for that
            // below does not really matter, but if you want you can
            // check if they are equal and skip the update below.
            setState(() {
              dialogSelectColor = newColor;
              modalcubit.setColor(newColor);
            });
          }),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) {
        setState(() => dialogPickerColor = color);
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }

  // Future<bool> colorPickerDialog() async {
  //   return ColorPicker(
  //     color: dialogPickerColor,
  //     onColorChanged: (Color color) =>
  //         setState(() => dialogPickerColor = color),
  //     width: 40,
  //     height: 40,
  //     borderRadius: 4,
  //     spacing: 5,
  //     runSpacing: 5,
  //     wheelDiameter: 155,
  //     heading: Text(
  //       'Select color',
  //       style: Theme.of(context).textTheme.titleMedium,
  //     ),
  //     subheading: Text(
  //       'Select color shade',
  //       style: Theme.of(context).textTheme.titleMedium,
  //     ),
  //     wheelSubheading: Text(
  //       'Selected color and its shades',
  //       style: Theme.of(context).textTheme.titleMedium,
  //     ),
  //     showMaterialName: true,
  //     showColorName: true,
  //     showColorCode: true,
  //     copyPasteBehavior: const ColorPickerCopyPasteBehavior(
  //       longPressMenu: true,
  //     ),
  //     materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
  //     colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
  //     colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
  //     colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
  //     selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
  //     pickersEnabled: const <ColorPickerType, bool>{
  //       ColorPickerType.both: false,
  //       ColorPickerType.primary: true,
  //       ColorPickerType.accent: true,
  //       ColorPickerType.bw: false,
  //       ColorPickerType.custom: true,
  //       ColorPickerType.wheel: true,
  //     },
  //     customColorSwatchesAndNames: colorsNameMap,
  //   ).showPickerDialog(
  //     context,
  //     actionsPadding: const EdgeInsets.all(16),
  //     constraints:
  //         const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
  //   );
  // }
}
