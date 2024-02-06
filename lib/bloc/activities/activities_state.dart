part of 'activities_cubit.dart';



sealed class ActivitiesState extends Equatable {

  final Activities activities;
  const ActivitiesState(this.activities);


  @override
  List<Object> get props => [];
}


class ActivitiesInitialState extends ActivitiesState {
  const ActivitiesInitialState(super.activities);
}

class ActivitiesUpdateState extends ActivitiesState{
   const ActivitiesUpdateState(super.activities);

  @override
  List<Object> get props => [activities];
}