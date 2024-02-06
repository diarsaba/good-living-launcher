import 'package:good_living_launcher/bloc/modal/modal_cubit.dart';
import 'package:good_living_launcher/bloc/service_locator.dart';

class Calendar {
  //final Day selected;
  final List<Day> days;

  List<String> weekdays_ = ["l", "m", "x", "j", "v", "s", "d"];
  List<String> weekdays_ENG = [
    "Mon.",
    "Tues.",
    "Wed.",
    "Thurs.",
    "Fri.",
    "Sat.",
    "Sun."
  ];
  List<String> weekdays_ESP = ["lun", "mar", "mie", "jue", "vie", "sab", "dom"];

  Calendar({required this.days});

  Calendar copyWith({
    Day? selected,
    List<Day>? days,
  }) =>
      Calendar(days: days ?? this.days);

  static Calendar initial() {
    List<String> weekdays = ["L", "M", "X", "J", "V", "S", "D"];
    List<String> months = [
      "enero",
      "febrero",
      "marzo",
      "abril",
      "mayo",
      "junio",
      "julio",
      "agosto",
      "septiembre",
      "octubre",
      "noviembre",
      "diciembre"
    ];
    DateTime dateTime = DateTime.now();
    String weekday_ = weekdays[dateTime.weekday - 1];
    String datecode =
        "${dateTime.day}${dateTime.weekday}${dateTime.month}${dateTime.year}";
    dateTime = dateTime.add(const Duration(days: -31));

    List<Day> listdays = [];

    for (var i = -30; i < 270; i++) {
      dateTime = dateTime.add(const Duration(days: 1));

      String day = dateTime.day.toString();
      String weekday = weekdays[dateTime.weekday - 1];
      String month = months[dateTime.month - 1];

      String code =
          "${dateTime.day}${dateTime.weekday}${dateTime.month}${dateTime.year}";

      final isToday = i == 0;
      final day_ = Day(
          day: day,
          weekday: weekday,
          month: month,
          datecode: code,
          today: isToday);

      listdays.add(day_);
    }

    getIt<ModalCubit>().setCalendarDateCode(datecode, weekday_);

    return Calendar( days: listdays);
  }
}

class Day {
  final bool today;
  final String day;
  final String weekday;
  final String month;
  final String datecode;

  Day(
      {required this.today,
      required this.day,
      required this.weekday,
      required this.month,
      required this.datecode});
}
