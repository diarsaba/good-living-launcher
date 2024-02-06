import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_living_launcher/bloc/blocs.dart';
import 'package:good_living_launcher/bloc/service_locator.dart';
import 'package:good_living_launcher/page.dart';

void main() {
  serviceLocatorInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ActivitiesCubit>()),
        BlocProvider(create: (_) => getIt<ModalCubit>()),
        BlocProvider(create: (_) => getIt<CalendarCubit>()),
      ],
      child: SafeArea(
        child: MaterialApp(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
          debugShowCheckedModeBanner: false,
          title: 'good live launcher',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const GoodLiveLauncherPage(),
        ),
      ),
    );
  }
}
