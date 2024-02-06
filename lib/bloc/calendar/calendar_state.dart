part of 'calendar_cubit.dart';

@immutable
sealed class CalendarState extends Equatable {
  final Calendar calendar;
  const CalendarState(this.calendar);

  @override
  List<Object> get props => [];
}

final class CalendarInitialState extends CalendarState {
  const CalendarInitialState(super.calendar);
}

final class CalendarUpdateState extends CalendarState {
  const CalendarUpdateState(super.calendar);

  @override
  List<Object> get props => [calendar];
}
