import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:good_living_launcher/bloc/activities/activities_cubit.dart';
import 'package:good_living_launcher/iconshandler.dart';
import 'package:good_living_launcher/modal.dart';
import 'package:good_living_launcher/models/activity.dart';
import 'package:pie_chart/pie_chart.dart';

class Solar extends StatefulWidget {
  const Solar({super.key});

  @override
  State<Solar> createState() => _SolarState();
}

class _SolarState extends State<Solar> {
  
  IconsHandler iconhandler = IconsHandler();
  Timer? timer;
  double da = 2 * pi / 86400;
  late double width = 0;
  late double centerX = 0;
  late double centerY = 0;
  late double radius = 0;
  late double radiusIcon = 0;

  @override
  void initState() {
    final double physicalWidth = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;
    final double devicePixelRatio =
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    width = physicalWidth / devicePixelRatio;
    centerX = width / 2;
    centerY = centerX / 2;
    radius = centerY - centerY / 4;
    radiusIcon = radius - 15;

    super.initState();

    setState(() {});
  }

  double timeToAngleDay(TimeOfDay time) {
    return (time.hour * 60 * 60 + time.minute * 60) * da - 21600;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (_, state) {
        return InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (builder) {
                  return const ModalInputs();
                });
          },
          child: SizedBox(
            height: centerX,
            child: Stack(
              children: [
                // Positioned(
                //     top: centerY - (((radius + 30) / 2) - 0),
                //     left: centerX - (((radius + 30) / 2) - 0),
                //     child: EasyPieChart(
                //       showValue: false,
                //       shouldAnimate: false,
                //       key: const Key('pie 1'),
                //       children: timepies,
                //       pieType: PieType.crust,
                //       onTap: (index) {
                //         print("en el $index de aplicacion");
                //       },
                //       gap: 0,
                //       start: 0,
                //       borderWidth: 3.5,
                //       size: radius + 50,
                //       borderEdge: StrokeCap.butt,
                //     )),
                Positioned(
                  top: centerY - (((radius + 30) / 2) - 5),
                  left: centerX - (((radius + 30) / 2) - 5),
                  child: PieChart(
                    key: const Key('circlepie'),
                    dataMap: state.activities.datamap,
                    animationDuration: const Duration(milliseconds: 0),
                    chartRadius: radius + 30,
                    colorList: state.activities.colorlist,
                    initialAngleInDegree: 90,
                    chartType: ChartType.disc,
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: false,
                    ),
                    baseChartColor: Colors.transparent,
                  ),
                ),
                Sun(
                  width: width,
                  centerX: centerX,
                  centerY: centerY,
                  radius: radius,
                ),
                ...builder(state)
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> builder(ActivitiesState state) {
    List<Widget> temp = [];
    for (var i = 0; i < state.activities.view.length; i++) {
      late double angletime;
      final activity = state.activities.view[i];
      if (activity is ActivityAlarm) {
        angletime = timeToAngleDay(activity.start);
        temp.add(Positioned(
          left: (centerX + radiusIcon * cos(angletime)),
          top: (centerY + radiusIcon * sin(angletime)),
          child: Icon(
            iconhandler.mapicon[activity.iconname]?.icon,
            color: Colors.black,
          ),
        ));
      }
      //  else {
      //   angletime = 21600;
      // }
    }
    return temp;
  }
}

//The sun is separated on StatefulWidget to performs the application
//if this is not maded of this way, instead to call the calculous for the new position sun and the draw
//all the widgets are updated at the same time rate as the sun is.
//this ocasion decressing the performace application.

//conclusion the Sun StatefulWidget is the only widget is updated each second.

class Sun extends StatefulWidget {
  final double width;
  final double centerX;
  final double centerY;
  final double radius;
  const Sun(
      {super.key,
      required this.width,
      required this.centerX,
      required this.centerY,
      required this.radius});

  @override
  State<Sun> createState() => _SunState();
}

class _SunState extends State<Sun> {
  Timer? timer;

  double sunXPosition = 0;
  double sunYPosition = 0;

  double da = 2 * pi / 86400; // 86400
  double a = 0;

  @override
  void initState() {
    super.initState();

    DateTime currenttime = DateTime.now();

    final horas = currenttime.hour * 60 * 60;
    final minutos = currenttime.minute * 60;
    final secods = currenttime.second;

    a = (horas + minutos + secods) * da - 21600;

    timer = Timer.periodic(
        const Duration(milliseconds: 1000), (Timer t) => updated());
  }

  void updated() {
    sunXPosition = (widget.centerX + widget.radius * cos(a));
    sunYPosition = (widget.centerY + widget.radius * sin(a));
    a += da;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: sunYPosition,
      left: sunXPosition,
      child: const Icon(
        FlutterRemix.sun_fill,
        color: Colors.yellow,
      ),
    );
  }
}
